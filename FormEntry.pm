package FormEntry;
use JSON;
use Dancer ':syntax';
use Dancer::Plugin::Database;
use Dancer::Plugin::Ajax;
#use Data::Dumper;

our $VERSION = '0.1';

sub calclv{

my $res=shift;
my $lv;
if($res<6){
	$lv='A0';
}elsif($res>=6 && $res<13){
	$lv='A1-';
}elsif($res>=13 && $res<19){
	$lv='A1';
}elsif($res>=19 && $res<25){
	$lv='A1+';
}elsif($res>=25 && $res<28){
	$lv='A2-';
}elsif($res>=28 && $res<31){
	$lv='A2';
}elsif($res>=31 && $res<34){
	$lv='A2+';
}elsif($res>=34 && $res<38){
	$lv='B1-';
}elsif($res>=38 && $res<42){
	$lv='B1';
}elsif($res>=42 && $res<47){
	$lv='B2-';
}elsif($res>=47 && $res<51){
	$lv='B2';
}elsif($res>=51 && $res<54){
	$lv='C1-';
}elsif($res>=54 && $res<58){
	$lv='C1';
}elsif($res>=58 && $res<60){
	$lv='C2-';
}elsif($res==60){
	$lv='C2';
}
return $lv;

}

#any '/form_entry' => sub {

#my $pid = 3*5;
#my $user=params->{user};
#my $uid=params->{uid};
#if($user && $uid){
# session user=>$user;
# session uid=>$uid;
#}
#if (($pid % session('uid')) == 0 ) {
#  my $now = ElaboraDati::data_corrente;
#  template 'form_entry.tt', {'now'=>$now, 'uid'=>session('uid')};
#}else{
#  redirect '/login?failed=2';
#}
#
#};

get '/listEntry' => sub {

#TODO: ALL case
my @days=qw(Su Mo Tu We Th Fr Sa);
my @res;
my $date = params->{date};
my $search=params->{search};
$search=~s/\'/\\'/g;
my $sql;
if($search ne ''){

$sql = "
select 
cr.id,
DAYOFWEEK(date) as dow,
DATE_FORMAT(cr.date, '%Y-%m-%d') as date,
cr.time,
cr.Slimit,
cr.onlinelink,
cr.password,
(SELECT COUNT(id) from entry_test_booking WHERE ids=cr.id and status > 0) as booked
FROM
 entry_test_session cr, entry_test_booking prb 
where cr.status=1 
and cr.id=prb.ids
and concat(prb.Name,' ',prb.Surname,' ',prb.Email,' ',prb.Note) like '%$search%'
order by DATEDIFF(date,'$date'), time
";

}else{

$sql = "
select 
cr.id,
DAYOFWEEK(date) as dow,
DATE_FORMAT(cr.date, '%Y-%m-%d') as date,
cr.time,
cr.Slimit,
cr.onlinelink,
cr.password,
(SELECT COUNT(id) from entry_test_booking WHERE ids=cr.id and status > 0) as booked
FROM
 entry_test_session cr 
where (date='0000-00-00' OR DATEDIFF(date,'$date') >= 0) and cr.status=1 
order by DATEDIFF(date,'$date'), time
";

}
#debug $sql;
my $sth = database->prepare($sql); 
$sth->execute();
while(my $ref =  $sth->fetchrow_hashref()){
#	$ref->{Name} = &goodName($ref->{Name});
#	$ref->{Surname} = &goodName($ref->{Surname});
	$ref->{dow} = ($ref->{dow}) ?  $days[$ref->{dow}-1] : ''; 
	push @res, $ref;
}
#Students query
foreach(@res){
	
my @stu;
my $id = $$_{'id'};
$sql ="select * 
from entry_test_booking prb  
WHERE prb.ids='$id' 
ORDER by id, Surname ASC, Name ASC";
$sth = database->prepare($sql); 
$sth->execute();
while(my $ref =  $sth->fetchrow_hashref()){
	$$ref{'Name'} = uc($$ref{'Name'});
	$$ref{'Surname'} = uc($$ref{'Surname'});
	$$ref{'lv'} = &calclv($$ref{'result'});
	my $telS;
	my $telW;
	my @telS=split('/',$$ref{'phone'});
	my @telN=split(' ',$telS[0]);
	foreach(@telN){
		if($_=~/\d+/){$telS.=$_};
	}
	my $l=length($telS);
	$$ref{'lenTS'}=$l;
	if($l==10){
		#Probably ok do nothing
		$telW=$telS;
        }elsif($l > 10){
		$telS=~/^(0039|39|\+39)(\d*)$/;
		$telW=$2;
		#$$ref{'test'}=$1;
	}elsif($l < 10){
		$telW='';
	}
	#$$ref{'telS'}=$telS;
	#$$ref{'telS'}=$telS;
	$$ref{'telW'}=$telW;
	push @stu, $ref;
}
push @{$$_{'students'}}, @stu;

} 
my %out = (result => \@res); 
content_type 'application/json';
return to_json \%out;

};

get '/addEntry' => sub {

my $res;
my $sql = "insert into entry_test_session set date='0000-00-00',time='00.00',Slimit='6'";
my $sth = database->prepare($sql); 
if($sth->execute()){
	$res="OK";
}else{
	$res="NO";
}
my %out = (result => $res); 
content_type 'application/json';
return to_json \%out;

};

get '/cancelEntry' => sub {

my $id = params->{id};
my $res;
my $sql = "update entry_test_session set status='2' where id='$id'";
my $sth = database->prepare($sql); 
if($sth->execute()){
	$res="OK";
}else{
	$res="NO! Cancle query failed";
}
my %out = (result => $res); 
content_type 'application/json';
return to_json \%out;

};

get '/delEntry' => sub {

#TODO: Control to delete only empty courses 
my $id = params->{id};
my $res;
my $sql ="select COUNT(id) from entry_test_booking WHERE ids='$id'";
my $sth = database->prepare($sql); 
$sth->execute();
my ($count) = $sth->fetchrow_array;
unless($count){

$sql = "delete from entry_test_session where id='$id'";
$sth = database->prepare($sql); 
if($sth->execute()){
	$res="OK";
}else{
	$res="NO! Delete query failed";
}

}else{
	$res="NO! Entry is't empty";
}
my %out = (result => $res); 
content_type 'application/json';
return to_json \%out;

};

get '/getDataEntry' => sub {

my $id = params->{id};
my @res;
my $sql ="select id, DATE_FORMAT(date, '%Y-%m-%d') AS date,time,`Slimit`,`onlinelink`,`password` from entry_test_session WHERE id='$id'";
my $sth = database->prepare($sql); 
$sth->execute();
while(my $ref =  $sth->fetchrow_hashref()){
	push @res, $ref;
}
my %out = (result => \@res); 
content_type 'application/json';
return to_json \%out;

};

post '/updateEntry' => sub {

my $id = params->{id};
my $date = params->{date};
my $time = params->{time};
my $limit = params->{limit};
my $onlinelink = params->{onlinelink};
my $password = params->{password};
my $res;
$date = $date;
my $sql ="
UPDATE `entry_test_session` SET 
`time`='$time',
`date`='$date',
`onlinelink`='$onlinelink',
`password`='$password',
`Slimit`='$limit'
WHERE id='$id'
";
my $sth = database->prepare($sql); 
if($sth->execute()){
	$res= 'OK';
}else{
	$res= 'NO';
}
my %out = (result => $res); 

content_type 'application/json';
return to_json \%out;

};

get '/getDataEntryStudent' => sub {

my $id = params->{id};
my @res;
my $sql ="
SELECT
*,
(SELECT
 CONCAT(ce.codice,' ',DATE_FORMAT(ce.data_inizio,'%Y-%m-%d'),' status ',ci.status)
 FROM  corsi_elenco ce, corsi_iscrizioni ci
 WHERE ce.id=ci.id_corso AND a.id=ci.id_corsista AND (ce.codice not like '%AllYouCanLearn%' OR ce.codice not like '%LanguageJourney%')
 ORDER BY ce.data_fine DESC
 LIMIT 1
) as lastCourse
FROM
 Anagrafica a
WHERE
 a.id='$id'
";
my $sth = database->prepare($sql); 
$sth->execute();
while(my $ref =  $sth->fetchrow_hashref()){
	push @res, $ref;
}
my %out = (result => \@res); 
content_type 'application/json';
return to_json \%out;

};

get '/getDataEntryIdAna' => sub {

my $id = params->{id};
my @res;
my $sql ="select id_ana from entry_test_booking WHERE id='$id'";
my $sth = database->prepare($sql); 
$sth->execute();
while(my $ref =  $sth->fetchrow_hashref()){
	push @res, $ref;
}
my %out = (result => \@res); 
content_type 'application/json';
return to_json \%out;

};
get '/copyEntrySession' => sub {

my $id = params->{id};
my $res;
my $sql ="select id,Date,Time,`Slimit`,onlinelink,password from entry_test_session WHERE id='$id'";
my $sth = database->prepare($sql); 
$sth->execute();
while(my $ref =  $sth->fetchrow_hashref()){
debug $ref;
$sql = "insert into entry_test_session SET 
`Time`='$$ref{'Time'}',
`Date`='$$ref{'Date'}',
`onlinelink`='$$ref{'onlinelink'}',
`password`='$$ref{'password'}',
`Slimit`='$$ref{'Slimit'}'
";
}
debug $sql;
$sth = database->prepare($sql); 
if($sth->execute()){
	$res="OK";
}else{
	$res="NO";
}
my %out = (result => $res); 
content_type 'application/json';
return to_json \%out;

};
post '/entryBookingStudent' => sub {

my $uid=session('uid');
my $id_entry = params->{id_entry};
my $id_ana = params->{id_ana};
my $name = params->{name};
my $surname = params->{surname};
my $dob = params->{dob};
my $email = params->{email};
my $phone = params->{phone};
my $type = params->{type};
my $notes = params->{notes};
my $notePC = params->{notesPC};
my $noteLE = params->{notesLE};
my $noteDT = params->{notesDT};
my $noteMA = params->{notesMA};
my $note="
Previous course:
$notePC
My last exam:
$noteLE
Reason for doing this test:
$noteDT
How did you find us?
$noteMA
Other:
$notes
";
my $res;
my $sql = "insert into entry_test_booking set ids=?,idp=?,name=?,surname=?,dob=?,email=?,phone=?,type=?,note=?,status=1";
my $sth = database->prepare($sql); 
if($sth->execute($id_entry,$id_ana,$name,$surname,$dob,$email,$phone,$type,$note)){
	$res="OK";
}else{
	$res="NO";
}
my %out = (result => $res); 
content_type 'application/json';
return to_json \%out;

};
ajax '/entryUpdateStudentBookingLevel' => sub {
my $id = params->{id};
my $level = params->{level};
my $res;
my $sql = "update entry_test_booking set level=? where id=?";
my $sth = database->prepare($sql); 
if($sth->execute($level,$id)){
	$res="OK";
}else{
	$res="NO";
}
my %out = (result => $res); 
content_type 'application/json';
return to_json \%out;
};
ajax '/entryUpdateStudentBookingTeacherInfo' => sub {
my $id = params->{id};
my $teacherInfo=params->{teacherInfo};
my $res;
my $sql = "update entry_test_booking set teacherInfo=? where id=?";
my $sth = database->prepare($sql); 
if($sth->execute($teacherInfo,$id)){
	$res="OK";
}else{
	$res="NO";
}
my %out = (result => $res); 
content_type 'application/json';
return to_json \%out;
};
ajax '/entryUpdateStudentBookingExtraInfo' => sub {
my $id = params->{id};
my $extra=params->{extra};
my $res;
my $sql = "update entry_test_booking set extraInfo=? where id=?";
my $sth = database->prepare($sql); 
if($sth->execute($extra,$id)){
	$res="OK";
}else{
	$res="NO";
}
my %out = (result => $res); 
content_type 'application/json';
return to_json \%out;
};
ajax '/entryUpdateStudentBooking' => sub {

my $id = params->{id};
my $name = params->{name};
my $surname = params->{surname};
my $dob = params->{dob};
my $phone = params->{phone};
my $email = params->{email};
my $type = params->{type};
my $note = params->{note};
my $res;
my $sql = "update entry_test_booking set name=?,surname=?,dob=?,phone=?,email=?,type=?,note=? where id=?";
my $sth = database->prepare($sql); 
if($sth->execute($name,$surname,$dob,$phone,$email,$type,$note,$id)){
	$res="OK";
}else{
	$res="NO";
}
my %out = (result => $res); 
content_type 'application/json';
return to_json \%out;

};

ajax '/entryDeleteStudentBooking' => sub {

my $id = params->{id};
#my $id_ana = params->{id_ana};
my $res;
my $sql = "delete from entry_test_booking where id=?";
my $sth = database->prepare($sql); 
if($sth->execute($id)){
	$res="OK";
}else{
	$res="NO";
}
my %out = (result => $res); 
content_type 'application/json';
return to_json \%out;

};
ajax '/assocTest2Book' => sub {

my $id = params->{id};
my $idp = params->{idp};
my $res;
my $sql = "update entry_test_booking set idp=? where id=?";
my $sth = database->prepare($sql); 
if($sth->execute($idp,$id)){
	$res="OK";
}else{
	$res="NO";
}
my %out = (result => $res); 
content_type 'application/json';
return to_json \%out;

};
get '/getEntryByDate' => sub{
my $date=params->{mdate};
my $sql="SELECT id,CONCAT(Time,' ',password) as des FROM entry_test_session WHERE Date=? ORDER BY Time";
my $sth = database->prepare($sql); 
$sth->execute($date);
my @res;
while(my $ref =  $sth->fetchrow_hashref()){
       push @res, $ref;
}
my %out = (result => \@res); 
content_type 'application/json';
return to_json \%out;
};
post '/moveEntryBooking' => sub {
my $idB = params->{idB};
my $ids = params->{ids};
my $res;
my $sql = "update entry_test_booking set ids=? where id=?";
my $sth = database->prepare($sql); 
if($sth->execute($ids,$idB)){
	$res="OK";
}else{
	$res="NO";
}
my %out = (result => $res); 
content_type 'application/json';
return to_json \%out;
};
get '/updateExtra' => sub{

my $id=params->{idE};
my $val=params->{extra};
my $res;
if($val){

my $sql = "update entry_test_placement set grade=? where id=?";
my $sth = database->prepare($sql); 
if($sth->execute($val,$id)){
	$res="OK";
}else{
	$res="NO";
}

}else{$res="OK";}
my %out = (result => $res); 
content_type 'application/json';
return to_json \%out;

};
get '/showMyWrittenTest' => sub{
 #GET booking id
 my $id=params->{id};
 #GET student id
 my $sql="SELECT idp as idS FROM entry_test_booking WHERE id='$id'";
 my $sth = database->prepare($sql); 
 $sth->execute();
 my ($idS) = $sth->fetchrow_array;
 $sth->finish();
 #GET written idref
 $sql="SELECT idref,grade,id FROM entry_test_placement WHERE id_ana='$idS' AND form = 'END OF TEST' ORDER BY id DESC LIMIT 1";
 $sth = database->prepare($sql); 
 $sth->execute();
 my ($idref,$extra,$idE) = $sth->fetchrow_array;
 $sth->finish();
 my @entryA;
 $sql = "select * from entry_test_placement WHERE idref='$idref' AND form!='END OF TEST' order by id";
 $sth = database->prepare($sql); 
 $sth->execute();
 while(my $row =  $sth->fetchrow_hashref()){
	push @entryA , $row;
 }
 my @res;
 my @per=(
	 'Ex1 not set',
	 'Ex2 not set',
	 'Ex3 not set',
	 'Ex4 not set',
	 'Ex5 not set'
 );
 my $tot;
 my @tmpl;
 my $j=0;
 for(my $i=0;$i<scalar(@entryA);$i++){
 #print Dumper $res;
  $j++;
  push @res,decode_json($entryA[$i]{'form'});

  $per[$i]='Ex'.$j.' '.$entryA[$i]{'grade'}.' of '.$entryA[$i]{'num'}.' '.$entryA[$i]{'per'}.'%';
  $tot+=$entryA[$i]{'grade'};
  push @tmpl,'form_'.$entryA[$i]{'template'}.'.tt';
 }
 template 'form_written_test.tt', 
 {	
	'tmplA'=>$tmpl[0],
	'tmplB'=>$tmpl[1],
	'tmplC'=>$tmpl[2],
	'tmplD'=>$tmpl[3],
	'tmplE'=>$tmpl[4],
	'entryA'=>$res[0],
	'entryB'=>$res[1],
	'entryC'=>$res[2],
	'entryD'=>$res[3],
	'entryE'=>$res[4],
	'perA'=>$per[0],
	'perB'=>$per[1],
	'perC'=>$per[2],
	'perD'=>$per[3],
	'perE'=>$per[4],
	'tot'=>$tot,
	'extra'=>$extra,
	'tot2'=>$tot+$extra,
	'idE'=>$idE,
	 'myTest'=>
	 sub{ 
		 my ($c,$e)=@_;
		 my $ret=0;
		 if($e ~~ $c){$ret =1;}
		 return $ret;
	 }
 },
 {
	 layout=>undef
 };
 #return "TEST >P ".$tmpl;
};
get '/showMyWrittenTestByIdS' => sub{
 #GET student id
 my $idS=params->{id};
 #GET written idref
 my $sql="SELECT idref,grade,id FROM entry_test_placement WHERE id_ana='$idS' AND form = 'END OF TEST' ORDER BY id DESC LIMIT 1";
 my $sth = database->prepare($sql); 
 $sth->execute();
 my ($idref,$extra,$idE) = $sth->fetchrow_array;
 $sth->finish();
 my @entryA;
 $sql = "select * from entry_test_placement WHERE idref='$idref' AND form!='END OF TEST' order by id";
 $sth = database->prepare($sql); 
 $sth->execute();
 while(my $row =  $sth->fetchrow_hashref()){
	push @entryA , $row;
 }
 my @res;
 my @per=(
	 'Ex1 not set',
	 'Ex2 not set',
	 'Ex3 not set',
	 'Ex4 not set',
	 'Ex5 not set'
 );
 my $tot;
 my @tmpl;
 my $j=0;
 for(my $i=0;$i<scalar(@entryA);$i++){
 #print Dumper $res;
  $j++;
  push @res,decode_json($entryA[$i]{'form'});

  $per[$i]='Ex'.$j.' '.$entryA[$i]{'grade'}.' of '.$entryA[$i]{'num'}.' '.$entryA[$i]{'per'}.'%';
  $tot+=$entryA[$i]{'grade'};
  push @tmpl,'form_'.$entryA[$i]{'template'}.'.tt';
 }
 template 'form_written_test.tt', 
 {	
	'tmplA'=>$tmpl[0],
	'tmplB'=>$tmpl[1],
	'tmplC'=>$tmpl[2],
	'tmplD'=>$tmpl[3],
	'tmplE'=>$tmpl[4],
	'entryA'=>$res[0],
	'entryB'=>$res[1],
	'entryC'=>$res[2],
	'entryD'=>$res[3],
	'entryE'=>$res[4],
	'perA'=>$per[0],
	'perB'=>$per[1],
	'perC'=>$per[2],
	'perD'=>$per[3],
	'perE'=>$per[4],
	'tot'=>$tot,
	'extra'=>$extra,
	'tot2'=>$tot+$extra,
	'idE'=>$idE,
	 'myTest'=>
	 sub{ 
		 my ($c,$e)=@_;
		 my $ret=0;
		 if($e ~~ $c){$ret =1;}
		 return $ret;
	 }
 },
 {
	 layout=>undef
 };
 #return "TEST >P ".$tmpl;
};

true;
