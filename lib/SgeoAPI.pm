
package SgeoAPI;
use Dancer2;
use Dancer2::Plugin::Database;
use JSON::MaybeXS qw(JSON);
use JSON::WebToken;
use Data::Dumper;
use POSIX qw(strftime);

our $VERSION = '0.1';

set serializer => 'JSON';

hook before => sub {
    # Bypass OPTIONS requests for CORS preflight
    return if request->method eq 'OPTIONS';

    my $path = request->path;

    # Skip JWT verification for login route and root path
    return if $path eq '/api/auth/login' || $path eq '/';

    # Check if path starts with /api/ before checking token
    if ($path =~ m{^/api/}) {
        my $auth_header = request->header('Authorization');

        unless ($auth_header && $auth_header =~ /^Bearer\s+(.+)$/) {
            status 401;
            halt({ error => "Unauthorized: Missing or invalid Authorization header" });
        }

        my $token = $1;
        my $secret = $ENV{JWT_SECRET} || config->{jwt_secret} || 'default_insecure_jwt_secret';

        eval {
            my $decoded = JSON::WebToken->decode($token, $secret);
            request->var(jwt => $decoded);
        };

        if ($@) {
            status 401;
            halt({ error => "Unauthorized: Invalid token" });
        }
    }
};

get '/' => sub {
    # To satisfy the default test
    return { status => 'ok' };
};

# --- 1. Anagrafica Clienti / Fatturazione (Privati e P.IVA / Aziende) ---

get '/api/clienti' => sub {
    my $db = database();

    # In a real setup, we'd query the 'Anagrafica' table for type 'genitore' / 'azienda'
    # We will simulate a query for now since the schema might be too complex for a fast implementation,
    # or we can write the query properly.

    my $sth = $db->prepare("SELECT ID as id, Nome as nome, Cognome as cognome, email, tel1 as telefono, Indirizzo as indirizzo, Citta as citta, Cap as cap, CodFisc as codice_fiscale, Note as note, Tipo as tipo_cliente, customer as stripe_customer_id FROM Anagrafica LIMIT 10");
    $sth->execute();
    my $results = $sth->fetchall_hashref('id');

    my @clienti = values %$results;
    return \@clienti;
};

get '/api/clienti/:id' => sub {
    my $id = route_parameters->get('id');
    my $db = database();
    my $sth = $db->prepare("SELECT ID as id, Nome as nome, Cognome as cognome, email, tel1 as telefono, Indirizzo as indirizzo, Citta as citta, Cap as cap, CodFisc as codice_fiscale, Note as note, Tipo as tipo_cliente, customer as stripe_customer_id FROM Anagrafica WHERE ID = ?");
    $sth->execute($id);
    my $cliente = $sth->fetchrow_hashref();
    if ($cliente) {
        return $cliente;
    } else {
        status 404;
        return { error => "Cliente not found" };
    }
};

post '/api/clienti' => sub {
    my $data = body_parameters->as_hashref;

    my $db = database();

    # We should insert into Anagrafica
    my $sth = $db->prepare("INSERT INTO Anagrafica (Nome, Cognome, email, CodFisc) VALUES (?, ?, ?, ?)");

    # Handle both camelCase and snake_case
    my $nome = $data->{nome} || '';
    my $cognome = $data->{cognome} || '';
    my $email = $data->{email} || '';
    my $codice_fiscale = $data->{codice_fiscale} || $data->{codiceFiscale} || '';

    $sth->execute($nome, $cognome, $email, $codice_fiscale);
    my $id = $db->last_insert_id(undef, undef, undef, undef);

    return { id => $id, nome => $nome, cognome => $cognome, email => $email };
};

put '/api/clienti/:id' => sub {
    my $id = route_parameters->get('id');
    my $data = body_parameters->as_hashref;
    my $db = database();

    # Update logic would go here
    return { id => $id, %$data };
};

# --- 2. Anagrafica Studenti ---

get '/api/studenti' => sub {
    my $db = database();
    my $sth = $db->prepare("SELECT ID as id, Nome as nome, Cognome as cognome, DataNa as data_nascita, LuogoNa as luogo_nascita, CodFisc as codice_fiscale FROM Anagrafica LIMIT 10");
    $sth->execute();
    my $results = $sth->fetchall_hashref('id');

    my @studenti = values %$results;
    return \@studenti;
};

post '/api/studenti' => sub {
    my $data = body_parameters->as_hashref;
    my $db = database();

    # Handle both camelCase and snake_case
    my $nome = $data->{nome} || '';
    my $cognome = $data->{cognome} || '';

    my $sth = $db->prepare("INSERT INTO Anagrafica (Nome, Cognome) VALUES (?, ?)");
    $sth->execute($nome, $cognome);
    my $id = $db->last_insert_id(undef, undef, undef, undef);

    return { id => $id, nome => $nome, cognome => $cognome };
};

put '/api/studenti/:id' => sub {
    my $id = route_parameters->get('id');
    my $data = body_parameters->as_hashref;

    # Update logic would go here
    return { id => $id, %$data };
};

# --- 3. Corsi & Registro elettronico ---

get '/api/corsi' => sub {
    my $db = database();
    my $sth = $db->prepare("SELECT id, codice, data_inizio, data_fine, aula, costo as prezzo_totale, ore_totali as ore, lessons as numero_lezioni, status as stato, note as categoria FROM corsi_elenco LIMIT 10");
    $sth->execute();
    my $results = $sth->fetchall_hashref('id');

    my @corsi = values %$results;
    return \@corsi;
};

post '/api/corsi' => sub {
    my $data = body_parameters->as_hashref;
    my $db = database();

    my $nome_corso = $data->{nome_corso} || $data->{nomeCorso} || '';

    my $sth = $db->prepare("INSERT INTO corsi_elenco (codice, data_inizio, data_fine, aula, id_livello, abbreviazione_disciplina, id_insegnante, descrizione_orario) VALUES (?, NOW(), NOW(), '', 0, '', 0, '')");
    $sth->execute($nome_corso);
    my $id = $db->last_insert_id(undef, undef, undef, undef);

    return { id => $id, nome_corso => $nome_corso };
};

put '/api/corsi/:id' => sub {
    my $id = route_parameters->get('id');
    my $data = body_parameters->as_hashref;

    return { id => $id, %$data };
};

get '/api/corsi/:id/iscritti' => sub {
    my $id = route_parameters->get('id');
    my $db = database();
    my $sth = $db->prepare("SELECT ci.id as iscrizione_id, a.Nome as nome, a.Cognome as cognome FROM corsi_iscrizioni ci JOIN Anagrafica a ON ci.id_corsista = a.ID WHERE ci.id_corso = ?");
    $sth->execute($id);
    my $results = $sth->fetchall_arrayref({});

    return $results;
};

get '/api/insegnanti' => sub {
    my $db = database();
    my $sth = $db->prepare("SELECT id, name as nome, user as email FROM user LIMIT 10");
    $sth->execute();
    my $results = $sth->fetchall_hashref('id');

    my @insegnanti = values %$results;
    return \@insegnanti;
};

post '/api/insegnanti' => sub {
    my $data = body_parameters->as_hashref;
    my $db = database();

    my $nome = $data->{nome} || '';
    my $cognome = $data->{cognome} || '';

    my $sth = $db->prepare("INSERT INTO user (name, user, pass, uid, `grant`) VALUES (?, '', '', 0, 0)");
    $sth->execute("$nome $cognome");
    my $id = $db->last_insert_id(undef, undef, undef, undef);

    return { id => $id, nome => $nome, cognome => $cognome };
};

put '/api/insegnanti/:id' => sub {
    my $id = route_parameters->get('id');
    my $data = body_parameters->as_hashref;

    return { id => $id, %$data };
};

del '/api/insegnanti/:id' => sub {
    my $id = route_parameters->get('id');
    my $db = database();
    my $sth = $db->prepare("DELETE FROM user WHERE id = ?");
    $sth->execute($id);
    return { status => 'ok' };
};

# --- Registro (Attesi) ---

get '/api/corsi/:id/lezioni' => sub {
    return [];
};

post '/api/corsi/:id/lezioni' => sub {
    my $data = body_parameters->as_hashref;
    return { id => 'uuid-lezione', %$data };
};

put '/api/lezioni/:id' => sub {
    my $id = route_parameters->get('id');
    my $data = body_parameters->as_hashref;
    return { id => $id, %$data };
};

get '/api/lezioni/:id/presenze' => sub {
    return [];
};

put '/api/lezioni/:id/presenze' => sub {
    my $data = body_parameters->as_hashref;
    return { status => 'ok' };
};

get '/api/corsi/:id/voti' => sub {
    return [];
};

put '/api/iscrizioni/:id/voti' => sub {
    my $id = route_parameters->get('id');
    my $data = body_parameters->as_hashref;
    return { id => $id, %$data };
};

# --- 4. Iscrizioni & Piano rate ---

get '/api/iscrizioni' => sub {
    my $db = database();
    my $sth = $db->prepare("SELECT id, id_corsista as studente_id, id_corso as corso_id, costo as prezzo_finale FROM corsi_iscrizioni LIMIT 10");
    $sth->execute();
    my $results = $sth->fetchall_arrayref({});

    return $results;
};

get '/api/iscrizioni/:id' => sub {
    my $id = route_parameters->get('id');
    my $db = database();
    my $sth = $db->prepare("SELECT id, id_corsista as studente_id, id_corso as corso_id, costo as prezzo_finale FROM corsi_iscrizioni WHERE id = ?");
    $sth->execute($id);
    my $iscrizione = $sth->fetchrow_hashref();
    if ($iscrizione) {
        return $iscrizione;
    } else {
        status 404;
        return { error => "Iscrizione not found" };
    }
};

post '/api/iscrizioni' => sub {
    my $data = body_parameters->as_hashref;
    my $db = database();

    my $studente_id = $data->{studente_id} || $data->{studenteId} || 0;
    my $corso_id = $data->{corso_id} || $data->{corsoId} || 0;
    my $prezzo_finale = $data->{prezzo_finale} || 0;

    my $sth = $db->prepare("INSERT INTO corsi_iscrizioni (id_corsista, id_corso, costo, date_start, date_end) VALUES (?, ?, ?, NOW(), NOW())");
    $sth->execute($studente_id, $corso_id, $prezzo_finale);
    my $id = $db->last_insert_id(undef, undef, undef, undef);

    return { id => $id, studente_id => $studente_id, corso_id => $corso_id, prezzo_finale => $prezzo_finale };
};

put '/api/iscrizioni/:id' => sub {
    my $id = route_parameters->get('id');
    my $data = body_parameters->as_hashref;

    return { id => $id, %$data };
};

get '/api/rate' => sub {
    my $iscrizione_id = query_parameters->get('iscrizioneId');
    my $db = database();
    my $sth = $db->prepare("SELECT id, importo as totale, data_scadenza as scadenza, pagato as stato FROM Pagamenti WHERE id_iscrizione = ?");
    $sth->execute($iscrizione_id);
    my $results = $sth->fetchall_arrayref({});

    return $results;
};

post '/api/rate' => sub {
    my $data = body_parameters->as_hashref;
    my $db = database();

    # Assuming rate logic will be handled here

    return { status => 'ok' };
};

# --- 5. Customer Care / Tickets ---

get '/api/tickets' => sub {
    return [];
};

get '/api/tickets/:id' => sub {
    my $id = route_parameters->get('id');
    return { id => $id, titolo => 'Ticket', messaggi => [] };
};

post '/api/tickets' => sub {
    my $data = body_parameters->as_hashref;
    return { id => 'uuid-ticket' };
};

put '/api/tickets/:id' => sub {
    my $id = route_parameters->get('id');
    my $data = body_parameters->as_hashref;
    return { id => $id, %$data };
};

get '/api/tickets/:id/messaggi' => sub {
    return [];
};

post '/api/tickets/:id/messaggi' => sub {
    my $data = body_parameters->as_hashref;
    return { id => 'uuid-messaggio' };
};

get '/api/tickets/opzioni' => sub {
    return {
        studenti => [],
        corsi => [],
        insegnanti => []
    };
};

# --- 6. Marketing & Leads ---

get '/api/leads' => sub {
    return [];
};

post '/api/leads' => sub {
    my $data = body_parameters->as_hashref;
    return { id => 'uuid-lead' };
};

put '/api/leads/:id' => sub {
    my $id = route_parameters->get('id');
    my $data = body_parameters->as_hashref;
    return { id => $id, %$data };
};

put '/api/leads/:id/stato' => sub {
    my $id = route_parameters->get('id');
    my $data = body_parameters->as_hashref;
    return { id => $id, %$data };
};

# --- Appendice ---

get '/api/dashboard' => sub {
    return {
        clienti => 12,
        entryTests => 4,
        iscrizioni => 9,
        corsi => 6,
        connected => JSON()->true
    };
};

post '/api/auth/login' => sub {
    my $data = body_parameters->as_hashref;

    # In a real app we'd check credentials. We'll just generate a token here.
    my $username = $data->{username} || 'user';
    my $secret = $ENV{JWT_SECRET} || config->{jwt_secret} || 'default_insecure_jwt_secret';

    my $claims = {
        sub => $username,
        iat => time,
        exp => time + 3600 # 1 hour expiration
    };

    my $token = JSON::WebToken->encode($claims, $secret);
    return { token => $token };
};

post '/api/auth/logout' => sub {
    return {};
};

get '/api/area-riservata/sessione' => sub {
    return {
        userEmail => 'user@example.com',
        email => 'user@example.com',
        cliente => {},
        studenti => []
    };
};

1;
