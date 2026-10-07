# CRM IH Palermo — Contratto HTTP per il micro-backend

Documento generato dallo SPA Vite (`src/lib/apiClient.ts` + `src/services/*`).  
Descrive **ciò che il frontend chiama oggi** e, dove il dominio c’è ma l’HTTP manca, il **contratto atteso**.

---

## Convenzioni comuni

### Base URL

- Header dello SPA: `VITE_API_BASE_URL` (es. `http://localhost:4000`).
- Se assente: fallback `http://localhost:8000/api`.
- Tutti i path in questo documento partono da **`/api/...`**. Se la base termina già con `/api`, il client **non duplica** il prefisso (`/api` + `/api/studenti` → `/api/studenti`).

### Autenticazione

- Header: `Authorization: Bearer <token>` se presente in `localStorage` (`ih-auth-token`).
- Header: `Accept: application/json`; su POST/PUT/PATCH anche `Content-Type: application/json`.
- **401**: il client cancella il token.

### Inviluppo risposta

Il client accetta:

- lista: array nudo, oppure `{ data: [] }`, `{ items: [] }`, `{ results: [] }`
- singolo: oggetto nudo, oppure `{ data: { ... } }`
- se arriva un array su un GET “singolo”, usa il primo elemento

Errori HTTP: JSON con `error` | `message` | `detail` (stringa). Stati gestiti in UI: `400`, `401`, `403`, `404`, `5xx`.

### Dual naming (camelCase + snake_case)

Il frontend **invia entrambi** i nomi dove il dominio è critico (es. `clienteId` e `cliente_id`).  
In lettura accetta **entrambi**. Preferire **snake_case** in persistence; camelCase in JSON è ok se allineato.

### Logica che resta sul client (non duplicare in modo divergente)

- Sconto famiglia: `calcolaSconto` — 5% sul listino; cumulativo = 5% proprio + 5% sul listino del primo fratello senza sconto famiglia, stesso anno accademico (1 set – 31 ago, fuso Roma).
- Piano rate: `calcolaPianoRate` — marca da bollo **2 €** se la **singola quota** è **> 77 €**.

---

## 1. Anagrafica Clienti / Fatturazione (Privati e P.IVA / Aziende)

Pagatore = genitore o azienda intestataria. Non è lo studente.

`tipo_cliente`: `"privato"` | `"azienda"`.  
Se `ragione_sociale` è valorizzata, lo SPA tratta il record come azienda.

### Validazioni UI (da rispettare in API)

**Privato**

- `nome`, `cognome` obbligatori
- `codice_fiscale` 16 caratteri

**Azienda**

- `ragione_sociale` obbligatoria
- `partita_iva` 11 cifre (senza `IT`)
- `codice_sdi` default `"0000000"` se vuoto
- `pec` opzionale
- `nome` può coincidere con la ragione sociale; `cognome` vuoto

### `GET /api/clienti`

Lista famiglie/pagatori.

**Query:** nessuna.

**Response (elemento):**

```json
{
  "id": "uuid",
  "nome": "Maria",
  "cognome": "Rossi",
  "email": "maria@example.com",
  "telefono": "+39...",
  "indirizzo": "Via Roma 1",
  "citta": "Palermo",
  "cap": "90100",
  "codice_fiscale": "RSSMRA80A01G273X",
  "note": null,
  "stripe_customer_id": null,
  "tipo_cliente": "privato",
  "ragione_sociale": null,
  "partita_iva": null,
  "codice_sdi": null,
  "pec": null,
  "studenti": [
    {
      "id": "uuid",
      "cliente_id": "uuid",
      "nome": "Luca",
      "cognome": "Rossi",
      "data_nascita": "2012-05-01",
      "luogo_nascita": "Palermo",
      "codice_fiscale": "...",
      "ha_sen": false,
      "sen_dettaglio": null,
      "ha_allergie": false,
      "allergie_dettaglio": null
    }
  ]
}
```

Nested `studenti` è opzionale: se manca, lo SPA mostra il pagatore senza figli.

### `GET /api/clienti/:id`

Stesso JSON di un elemento della lista (con `studenti` se possibile).

### `POST /api/clienti`

Crea pagatore. Body (il client manda snake_case **e** i campi form camelCase):

```json
{
  "nome": "Acme Srl",
  "cognome": "",
  "email": "admin@acme.it",
  "telefono": null,
  "indirizzo": null,
  "citta": null,
  "cap": null,
  "codice_fiscale": "12345678901",
  "tipo_cliente": "azienda",
  "ragione_sociale": "Acme Srl",
  "partita_iva": "12345678901",
  "codice_sdi": "0000000",
  "pec": "acme@pec.it",
  "tipoCliente": "azienda",
  "ragioneSociale": "Acme Srl",
  "partitaIva": "12345678901",
  "codiceSdi": "0000000"
}
```

**Response:** oggetto cliente creato (`id` obbligatorio).

### `PUT /api/clienti/:id`

Stesso body di POST (aggiornamento parziale accettato). Lo SPA può inviare anche `note`.

**Response:** cliente aggiornato.

---

## 2. Anagrafica Studenti (minorenni / maggiorenni, SEN, allergie)

Minorenne = età inferiore a 18 anni in fuso `Europe/Rome` da `data_nascita` (`YYYY-MM-DD`).

- **Minorenne:** obbligatorio un `cliente_id` (genitore/pagatore). Non può auto-fatturarsi.
- **Maggiorenne:** può essere il pagatore (`pagatoreMode: "self"`): si crea/aggiorna prima il cliente, poi lo studente con quel `cliente_id`.

### Segnalazioni (obbligatorie in persistenza)

| Campo JSON (preferito) | Tipo | Note |
| --- | --- | --- |
| `ha_sen` | boolean | Bisogni educativi speciali |
| `sen_dettaglio` | string \| null | Testo libero se `ha_sen` |
| `ha_allergie` | boolean | Allergie / intolleranze |
| `allergie_dettaglio` | string \| null | Testo libero se `ha_allergie` |

Il mapper UI legge **`ha_sen` / `sen_dettaglio` / `ha_allergie` / `allergie_dettaglio`**. Restituirli in snake_case.

### `GET /api/studenti`

**Response (elemento):** dati studente + pagatore (nested o flatten).

Nested accettati: `clienti` | `cliente` | `genitore`.

```json
{
  "id": "uuid",
  "cliente_id": "uuid",
  "nome": "Luca",
  "cognome": "Rossi",
  "data_nascita": "2012-05-01",
  "luogo_nascita": "Palermo",
  "codice_fiscale": "...",
  "ha_sen": true,
  "sen_dettaglio": "DSA — tempi aggiuntivi",
  "ha_allergie": true,
  "allergie_dettaglio": "Nocciole",
  "cliente": {
    "nome": "Maria",
    "cognome": "Rossi",
    "email": "...",
    "telefono": "...",
    "indirizzo": "...",
    "citta": "...",
    "cap": "...",
    "codice_fiscale": "...",
    "tipo_cliente": "privato",
    "ragione_sociale": null,
    "partita_iva": null,
    "codice_sdi": null,
    "pec": null
  }
}
```

Flatten alternativi: `genitoreNome`, `genitoreCognome`, `genitoreEmail`, `genitoreTelefono`, `genitoreIndirizzo`, `genitoreCitta`, `genitoreCap`, `genitoreCodiceFiscale`, `genitoreTipoCliente`, `genitoreRagioneSociale`, `genitorePartitaIva`, `genitoreCodiceSdi`, `genitorePec`.

### `POST /api/studenti`

```json
{
  "clienteId": "uuid",
  "cliente_id": "uuid",
  "nome": "Luca",
  "cognome": "Rossi",
  "dataNascita": "2012-05-01",
  "data_nascita": "2012-05-01",
  "luogoNascita": "Palermo",
  "luogo_nascita": "Palermo",
  "codiceFiscale": "RSSLCU12E01G273X",
  "codice_fiscale": "RSSLCU12E01G273X",
  "haSen": false,
  "ha_sen": false,
  "senDettaglio": null,
  "sen_dettaglio": null,
  "haAllergie": false,
  "ha_allergie": false,
  "allergieDettaglio": null,
  "allergie_dettaglio": null
}
```

**Response:** studente con `id`.

### `PUT /api/studenti/:id`

Stesso body di POST.

---

## 3. Corsi & Registro elettronico (presenze, voti Mid/Final, diario)

### Catalogo corsi (implementato)

Stati usati in UI: `"attivo"` (default se null), `"archiviato"`.

### `GET /api/corsi`

**Response (elemento):**

```json
{
  "id": "uuid",
  "codice": "YL-A1-LUN",
  "nome_corso": "Young Learners A1",
  "livello": "A1",
  "tipo_corso": "YL",
  "orario": "16:00-17:30",
  "giorni": "Lun/Mer",
  "data_inizio": "2026-09-15",
  "data_fine": "2027-06-15",
  "docente": "Anna Bianchi",
  "docente_id": "uuid",
  "aula": "Aula 2",
  "prezzo_totale": 890,
  "ore": 90,
  "numero_lezioni": 60,
  "stato": "attivo",
  "categoria": "YL",
  "posti_totali": 12,
  "haSegnalazioni": false,
  "insegnanti": { "nome": "Anna", "cognome": "Bianchi" }
}
```

`insegnanti` può essere oggetto o array (primo elemento). `tipo_corso` con `yl` / `young` → default **8 rate**; `adult` → **4 rate**.

### `POST /api/corsi`

Creazione da catalogo UI (minimo):

```json
{
  "nomeCorso": "Adults B1 evening",
  "nome_corso": "Adults B1 evening",
  "categoria": "Adults",
  "postiTotali": 10,
  "posti_totali": 10,
  "stato": "attivo"
}
```

### `PUT /api/corsi/:id`

Aggiornamenti usati:

```json
{
  "docente_id": "uuid",
  "docenteId": "uuid",
  "docente": "Anna Bianchi",
  "aula": "Aula 2",
  "orario": "18:00-19:30",
  "giorni": "Mar/Gio",
  "stato": "archiviato"
}
```

### `GET /api/corsi/:id/iscritti`

Studenti iscritti al corso (per registro / badge SEN).

**Response:** lista (o `{ data: [] }`).

```json
{
  "id": "uuid-studente-o-iscrizione",
  "nome": "Luca",
  "cognome": "Rossi",
  "stato_iscrizione": "confermata",
  "genitore": "Maria Rossi",
  "genitoreNome": "Maria",
  "genitoreCognome": "Rossi",
  "tipo_cliente": "privato",
  "ragione_sociale": null,
  "partita_iva": null,
  "ha_sen": true,
  "sen_dettaglio": "...",
  "ha_allergie": false,
  "allergie_dettaglio": null
}
```

### Insegnanti (supporto corsi)

| Metodo | URL | Body | Response |
| --- | --- | --- | --- |
| GET | `/api/insegnanti` | — | lista |
| POST | `/api/insegnanti` | sotto | insegnante |
| PUT | `/api/insegnanti/:id` | sotto | insegnante |
| DELETE | `/api/insegnanti/:id` | — | ok |

```json
{
  "nome": "Anna",
  "cognome": "Bianchi",
  "email": "anna@ihpalermo.it",
  "telefono": null,
  "note": null,
  "coloreCalendario": "#c8102e",
  "colore_calendario": "#c8102e",
  "stato": "attivo"
}
```

`stato`: `"attivo"` | `"inattivo"`. Disattivazione = PUT `{ "stato": "inattivo" }`.

### Registro elettronico — **non ancora chiamato dallo SPA**

Contratto atteso (allineato al dominio corsi / iscritti). Implementarli così lo SPA potrà agganciarli senza cambiare modello.

#### `GET /api/corsi/:id/lezioni`

Elenco lezioni (diario di classe).

**Response (elemento):**

```json
{
  "id": "uuid",
  "corso_id": "uuid",
  "data": "2026-10-06",
  "ora_inizio": "16:00",
  "ora_fine": "17:30",
  "argomento": "Unit 3 — Present simple",
  "diario": "Ripasso homework. Introduzione new vocab.",
  "insegnante_id": "uuid",
  "stato": "svolta"
}
```

#### `POST /api/corsi/:id/lezioni`

Crea lezione + riga diario.

```json
{
  "data": "2026-10-06",
  "ora_inizio": "16:00",
  "ora_fine": "17:30",
  "argomento": "...",
  "diario": "...",
  "insegnante_id": "uuid"
}
```

#### `PUT /api/lezioni/:id`

Aggiorna diario / orario / stato (`pianificata` | `svolta` | `annullata`).

#### `GET /api/lezioni/:id/presenze`

```json
{
  "lezione_id": "uuid",
  "studente_id": "uuid",
  "iscrizione_id": "uuid",
  "stato": "presente",
  "note": null
}
```

`stato` presenza: `"presente"` | `"assente"` | `"ritardo"` | `"giustificato"`.

#### `PUT /api/lezioni/:id/presenze`

Salvataggio massivo:

```json
{
  "presenze": [
    { "studente_id": "uuid", "stato": "presente", "note": null }
  ]
}
```

#### `GET /api/corsi/:id/voti`  e  `PUT /api/iscrizioni/:id/voti`

Voti **Mid** (intermedio) e **Final** (fine corso), per iscritto.

```json
{
  "iscrizione_id": "uuid",
  "studente_id": "uuid",
  "corso_id": "uuid",
  "voto_mid": 72,
  "voto_mid_data": "2026-02-10",
  "voto_mid_note": "Speaking B1-",
  "voto_final": 81,
  "voto_final_data": "2026-06-10",
  "voto_final_cefr": "B1",
  "voto_final_note": null
}
```

Scala: numerica 0–100 e/o etichetta CEFR. Assenti = `null`.

---

## 4. Iscrizioni & Piano rate (sconti, marca da bollo, scadenziario)

### Stati iscrizione usati dallo SPA

| Valore | Significato |
| --- | --- |
| `corso_proposto` | Proposta da pipeline / anagrafica studente |
| `modulo_inviato` | Modulo iscrizione inviato |
| `confermata` | Iscrizione confermata in sede |
| `cancellato` | Non interessato / perso |

### Query lista

`GET /api/iscrizioni`

| Query | Uso |
| --- | --- |
| `clienteId` | Filtra per pagatore |
| `studenteId` | Filtra per studente |
| `escludiIscrizioneId` | Esclude un id (sconto famiglia: altri figli) |

### `GET /api/iscrizioni`

Due forme accettate:

**A — già denormalizzata (pipeline)**

```json
{
  "id": "uuid",
  "cliente_id": "uuid",
  "studente_id": "uuid",
  "nome": "Luca",
  "cognome": "Rossi",
  "nomeGenitore": "Maria Rossi",
  "cognomeGenitore": "",
  "email": "...",
  "telefono": "...",
  "nomeCorso": "YL A1 Lun/Mer",
  "livelloCorso": "A1",
  "tipoCorso": "YL",
  "prezzoCorso": 845.5,
  "prezzo_listino": 890,
  "sconto_tipo": "famiglia_5",
  "sconto_percentuale": 5,
  "sconto_importo": 44.5,
  "prezzo_finale": 845.5,
  "dataInizioCorso": "2026-09-15",
  "data_iscrizione": "2026-10-01",
  "stato_iscrizione": "corso_proposto",
  "stripe_customer_id": null,
  "metodo_pagamento_offline": null,
  "tipo_saldo_offline": null,
  "note": null,
  "assegnato_a": "Olga",
  "motivo_cancellazione": null,
  "updated_at": "2026-10-06T12:00:00.000Z",
  "tipo_cliente": "privato",
  "ragione_sociale": null,
  "partita_iva": null,
  "codice_sdi": null,
  "pec": null
}
```

**B — relazionale** (join `clienti`, `studenti`, `corsi`):

```json
{
  "id": "uuid",
  "cliente_id": "uuid",
  "studente_id": "uuid",
  "stato_iscrizione": "confermata",
  "prezzo_listino": 890,
  "sconto_tipo": "nessuno",
  "sconto_percentuale": 0,
  "sconto_importo": 0,
  "prezzo_finale": 890,
  "data_iscrizione": "2026-10-01",
  "note": null,
  "assegnato_a": null,
  "motivo_cancellazione": null,
  "stripe_customer_id": null,
  "metodo_pagamento_offline": "Bonifico",
  "tipo_saldo_offline": "Piano Rate",
  "updated_at": "...",
  "clienti": { "nome": "...", "cognome": "...", "email": "...", "telefono": "...", "tipo_cliente": "privato", "ragione_sociale": null, "partita_iva": null, "codice_sdi": null, "pec": null, "stripe_customer_id": null },
  "studenti": { "id": "uuid", "cliente_id": "uuid", "nome": "...", "cognome": "...", "clienti": { } },
  "corsi": { "codice": "...", "tipo_corso": "YL", "livello": "A1", "giorni": "...", "orario": "...", "prezzo_totale": 890, "data_inizio": "2026-09-15" }
}
```

Join possono essere oggetto o array (si prende il primo).

### `GET /api/iscrizioni/:id`

Stesso JSON di un elemento.

### `POST /api/iscrizioni`

Proposta corso:

```json
{
  "clienteId": "uuid",
  "cliente_id": "uuid",
  "studenteId": "uuid",
  "studente_id": "uuid",
  "corsoId": "uuid",
  "corso_id": "uuid",
  "prenotazioneId": "uuid-lead-opzionale",
  "statoIscrizione": "corso_proposto",
  "stato_iscrizione": "corso_proposto",
  "prezzo_listino": 890,
  "sconto_tipo": "famiglia_cumulativo",
  "sconto_percentuale": 10.56,
  "sconto_importo": 94,
  "prezzo_finale": 796
}
```

`sconto_tipo`: `"nessuno"` | `"famiglia_5"` | `"famiglia_cumulativo"` | `"personalizzato"`.

**Response:** oggetto con `id`.

### `PUT /api/iscrizioni/:id`

Patch parziali dallo SPA:

**Note / assegnazione**

```json
{ "note": "...", "assegnatoA": "Olga", "assegnato_a": "Olga" }
```

**Modulo inviato**

```json
{ "statoIscrizione": "modulo_inviato", "stato_iscrizione": "modulo_inviato" }
```

**Cancellazione**

```json
{
  "statoIscrizione": "cancellato",
  "stato_iscrizione": "cancellato",
  "motivoCancellazione": "Prezzo",
  "motivo_cancellazione": "Prezzo"
}
```

**Conferma in sede**

```json
{
  "statoIscrizione": "confermata",
  "stato_iscrizione": "confermata",
  "metodoPagamentoOffline": "Stripe",
  "metodo_pagamento_offline": "Stripe",
  "tipoSaldoOffline": "Piano Rate",
  "tipo_saldo_offline": "Piano Rate",
  "prezzo_listino": 890,
  "sconto_tipo": "famiglia_5",
  "sconto_percentuale": 5,
  "sconto_importo": 44.5,
  "prezzo_finale": 845.5,
  "prezzoPiano": 845.5,
  "accontoPiano": 100,
  "numeroRate": 8,
  "stripePianoPronto": true
}
```

Metodi pagamento: `"POS (Carta/Bancomat)"` | `"Contanti"` | `"Bonifico"` | `"Stripe POS"` | `"Stripe"`.  
Tipo saldo: `"Unica Soluzione"` | `"Prima Rata"` | `"Piano Rate"`.  
`stripePianoPronto` true se metodo è `"Stripe"` o `"stripe sepa/carta"`.

### Marca da bollo (calcolo client, persistenza rate)

- Soglia: quota corso **> 77 €** → **+ 2 €** su quella voce.
- Non si applica sull’intero corso, ma su **ogni acconto/rata**.

### `POST /api/rate`

Sostituisce (o upsert) lo scadenziario dell’iscrizione.

```json
{
  "iscrizioneId": "uuid",
  "iscrizione_id": "uuid",
  "metodoPagamento": "Stripe",
  "stripeReady": true,
  "piano": {
    "numeroRate": 8,
    "acconto": 100,
    "totaleDaRateizzare": 745.5,
    "voci": [
      {
        "indice": 0,
        "tipo": "acconto",
        "etichetta": "Acconto",
        "scadenza": "2026-10-06",
        "quotaCorso": 100,
        "marcaDaBollo": 2,
        "totale": 102
      },
      {
        "indice": 1,
        "tipo": "rata",
        "etichetta": "Rata 1/8",
        "scadenza": "2026-11-15",
        "quotaCorso": 93.19,
        "marcaDaBollo": 2,
        "totale": 95.19
      }
    ],
    "totaleQuoteCorso": 845.5,
    "totaleMarcheDaBollo": 18,
    "totaleComplessivo": 863.5
  },
  "voci": []
}
```

`voci` è duplicato di `piano.voci`. `tipo` voce: `"acconto"` | `"rata"`. Date `YYYY-MM-DD`.

### `GET /api/rate?iscrizioneId=:id`

**Response (elemento rata persistita):**

```json
{
  "id": "uuid",
  "indice": 1,
  "tipo": "rata",
  "etichetta": "Rata 1/8",
  "scadenza": "2026-11-15",
  "quotaCorso": 93.19,
  "quota_corso": 93.19,
  "marcaDaBollo": 2,
  "marca_da_bollo": 2,
  "totale": 95.19,
  "stato": "da_pagare",
  "stripeReady": true,
  "stripe_ready": true
}
```

`stato` suggerito: `"da_pagare"` | `"pagata"` | `"scaduta"` | `"annullata"`.

---

## 5. Customer Care / Tickets (stati, messaggi, note interne)

### Enum

**Stato:** `aperto` | `in_lavorazione` | `in_attesa` | `chiuso`  
**Priorità:** `urgente` | `alta` | `media` | `bassa`  
**Categoria create:** `Generale` | `Didattica` | `Amministrazione` | `Orari` | `Certificati` | `Reclamo`  
(in filtro UI anche `Pagamenti`, `Segreteria`, `Tecnico`, `Altro`)

Messaggio **pubblico:** `interno: false` (visibile area riservata / genitore).  
**Nota interna:** `interno: true` (solo staff).

### `GET /api/tickets`

Query: `clienteId`, `studenteId`.

**Response (elemento):**

```json
{
  "id": "uuid",
  "cliente_id": "uuid",
  "studente_id": "uuid",
  "corso_id": "uuid",
  "etichettaCorso": "YL A1 Lun/Mer",
  "insegnante": "Anna Bianchi",
  "titolo": "Richiesta giustifica",
  "categoria": "Didattica",
  "priorita": "media",
  "stato": "aperto",
  "assegnato_a": "Olga",
  "descrizione": "...",
  "created_at": "...",
  "updated_at": "...",
  "nomeCliente": "Maria Rossi",
  "nomeStudente": "Luca Rossi",
  "ha_sen": false,
  "sen_dettaglio": null,
  "studenti": { "nome": "Luca", "cognome": "Rossi", "ha_sen": false, "sen_dettaglio": null },
  "clienti": { "nome": "Maria", "cognome": "Rossi" }
}
```

Nested `studenti` / `clienti` opzionali se i flatten `nomeStudente` / `nomeCliente` sono presenti.

### `GET /api/tickets/:id`

Come sopra; può includere `messaggi: [ ... ]`. Se `messaggi` manca, lo SPA chiama `GET /api/tickets/:id/messaggi`.

### `POST /api/tickets`

```json
{
  "clienteId": "uuid",
  "cliente_id": "uuid",
  "studenteId": "uuid",
  "studente_id": "uuid",
  "corsoId": "uuid",
  "corso_id": "uuid",
  "insegnante": "Anna Bianchi",
  "titolo": "...",
  "categoria": "Didattica",
  "priorita": "media",
  "stato": "aperto",
  "assegnatoA": "Olga",
  "assegnato_a": "Olga",
  "descrizione": "Testo iniziale"
}
```

Almeno `cliente_id` **o** `studente_id`. **Response:** `{ "id": "..." }`.  
Se `descrizione` è valorizzata, lo SPA crea subito un messaggio pubblico.

### `PUT /api/tickets/:id`

```json
{
  "stato": "in_lavorazione",
  "priorita": "alta",
  "assegnatoA": "Elena",
  "assegnato_a": "Elena"
}
```

### `GET /api/tickets/:id/messaggi`

```json
{
  "id": "uuid",
  "ticket_id": "uuid",
  "corpo": "Testo",
  "messaggio": "Testo",
  "interno": false,
  "is_interno": false,
  "autore": "Olga",
  "created_at": "..."
}
```

### `POST /api/tickets/:id/messaggi`

```json
{
  "corpo": "Nota riservata",
  "messaggio": "Nota riservata",
  "interno": true,
  "is_interno": true,
  "autore": "Segreteria"
}
```

### `GET /api/tickets/opzioni`

Lookup per form nuovo ticket. Se manca, fallback su GET studenti/corsi/insegnanti.

```json
{
  "studenti": [
    { "id": "uuid", "clienteId": "uuid", "nome": "Luca", "cognome": "Rossi" }
  ],
  "corsi": [
    {
      "id": "uuid",
      "nomeCorso": "...",
      "codice": "...",
      "tipoCorso": "YL",
      "livello": "A1",
      "giorni": "...",
      "orario": "...",
      "docente": "...",
      "docenteId": "uuid"
    }
  ],
  "insegnanti": [{ "id": "uuid", "nome": "Anna", "cognome": "Bianchi" }]
}
```

---

## 6. Marketing & Leads (First touch, Lead touch, GCLID, attribuzione)

Lead = prenotazione / entry test in pipeline.

### Stati marketing (`PUT .../stato`)

| Valore | Quando |
| --- | --- |
| `generate_lead` | Ingresso |
| `qualified_lead` | Orale registrato **o** corso proposto |
| `enrollment` | Iscrizione confermata (`revenue` = `prezzo_finale`) |

Lo SPA dopo l’orale imposta anche sul record lead `stato: "completato"` (stato **didattico** del test, distinto da quello marketing).

### Attribuzione (body create / persistenza)

| Campo | Significato |
| --- | --- |
| `firstTouch` / `first_touch` | Primo canale noto (UTM, referrer, campagna) |
| `leadTouch` / `lead_touch` | Canale al momento della conversione lead |
| `gclid` | Google Click ID |
| `selfReportedAttribution` / `self_reported_attribution` | Testo “come ci hai conosciuto” / output attribuzione AI |

`createLead` è già nel client; la pagina Entry Test è ancora placeholder: il backend deve comunque accettare questi campi.

### `GET /api/leads`

```json
{
  "id": "uuid",
  "cliente_id": "uuid",
  "nome": "Luca",
  "cognome": "Rossi",
  "data_ora_test": "2026-10-06T14:00:00.000Z",
  "lingua": "English",
  "lingua_interesse": "English",
  "stato": "generate_lead",
  "punteggio": 62,
  "livello_assegnato": "A2",
  "note_valutatore": "...",
  "risultato_id": null,
  "updated_at": "...",
  "first_touch": "google_ads",
  "lead_touch": "organic_search",
  "gclid": "Cj0KCQjw...",
  "self_reported_attribution": "Instagram / amico"
}
```

### `POST /api/leads`

```json
{
  "clienteId": "uuid",
  "email": "maria@example.com",
  "nome": "Luca",
  "cognome": "Rossi",
  "firstTouch": "google_ads",
  "leadTouch": "organic_search",
  "gclid": "Cj0KCQjw...",
  "selfReportedAttribution": "Passaparola"
}
```

**Response:** lead con `id`.

### `PUT /api/leads/:id`

Usato per l’orale:

```json
{
  "noteValutatore": "...",
  "note_valutatore": "...",
  "livelloAssegnato": "B1",
  "livello_assegnato": "B1",
  "stato": "completato"
}
```

### `PUT /api/leads/:id/stato`

```json
{ "stato": "qualified_lead" }
```

```json
{ "stato": "enrollment", "revenue": 845.5 }
```

Nota: in conferma iscrizione lo SPA chiama `PUT /api/leads/:iscrizioneId/stato`. Ideale: accettare **sia** `leadId` **sia** lookup per `iscrizione_id` / `prenotazione_id`.

---

## Appendice — altri endpoint già usati

### Dashboard

`GET /api/dashboard`

```json
{
  "clienti": 12,
  "entryTests": 4,
  "iscrizioni": 9,
  "corsi": 6,
  "connected": true
}
```

### Auth / area riservata

`POST /api/auth/login`

```json
{ "email": "user@example.com", "password": "..." }
```

Response: `{ "token": "..." }` oppure `{ "accessToken": "..." }`.

`POST /api/auth/logout` — body `{}`.

`GET /api/area-riservata/sessione`

```json
{
  "userEmail": "maria@example.com",
  "email": "maria@example.com",
  "cliente": { },
  "studenti": [ ]
}
```

Bearer obbligatorio.

### Webhook esterno (non è il micro-backend)

Alla proposta corso lo SPA può `POST` a `VITE_ZAPIER_PROPOSTA_WEBHOOK_URL`:

```json
{
  "cliente_id": "uuid",
  "email": "...",
  "nome_cliente": "...",
  "cognome_cliente": "...",
  "nome_corso": "...",
  "telefono": "..."
}
```

---

## Indice path implementati nello SPA

| Metodo | Path |
| --- | --- |
| GET | `/api/dashboard` |
| POST | `/api/auth/login` |
| POST | `/api/auth/logout` |
| GET | `/api/area-riservata/sessione` |
| GET POST | `/api/clienti` |
| GET PUT | `/api/clienti/:id` |
| GET POST | `/api/studenti` |
| PUT | `/api/studenti/:id` |
| GET POST | `/api/corsi` |
| PUT | `/api/corsi/:id` |
| GET | `/api/corsi/:id/iscritti` |
| GET POST | `/api/insegnanti` |
| PUT DELETE | `/api/insegnanti/:id` |
| GET POST | `/api/iscrizioni` |
| GET PUT | `/api/iscrizioni/:id` |
| GET POST | `/api/rate` |
| GET POST | `/api/tickets` |
| GET PUT | `/api/tickets/:id` |
| GET POST | `/api/tickets/:id/messaggi` |
| GET | `/api/tickets/opzioni` |
| GET POST | `/api/leads` |
| PUT | `/api/leads/:id` |
| PUT | `/api/leads/:id/stato` |

Path **attesi** per il registro (non ancora nello SPA):  
`/api/corsi/:id/lezioni`, `/api/lezioni/:id`, `/api/lezioni/:id/presenze`, `/api/corsi/:id/voti`, `/api/iscrizioni/:id/voti`.
