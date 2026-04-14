# Nome Sito: `AtelierDoisneau.it`

In occasione della mostra a Pordenone di Doisneau "Lo sguardo che racconta" dobbiamo sviluppare un sito per il curatore della mostra che permetta alla gente comune di acquistare piccoli souvenir della mostra (sei già andato) e permette a milionari di registrarsi per prenotare una specifica opera d'arte e poi andarla a ritirare alla mostra (e magari visitarla)

[Quindi le opere hanno 4 stati, Disponibile, Prenotato, Venduto, Non Disponibile]

Palette: Violetto & Oro

# Nome Azienda: `Silk & Stack`

Siamo un'azienda che si occupa di programmazione per aziende che hanno clienti facoltosi.

Struttura dell'azienda: 

- Riccardo (CEO) [Responabile]	
- Alex (Database/Tecnico reperibile) [Responsabile BackEnd]
- Luigi (Marketing & Social Manager) [Responsabile Rapporti Umani]
- Furio (Design & Archittetura Informazione) [Responsabile Front-end]

# struttura sito

## rest api

### necessarie

#### DB

##### products
- create : /api/products
- read (single and list) : /api/products[/id/]
//tra quadre la parte che cambia in base al record singolo o alla lista
- update : /api/products/id
- delete : /api/products/id

##### photos
- create : /api/photos
- read (single and list) : /api/photos[/id/]
//tra quadre la parte che cambia in base al record singolo o alla lista
- update : /api/photos/id
- delete : /api/photos/id

##### users
- create : /api/users
- read (single and list) : /api/users[/id/]
//tra quadre la parte che cambia in base al record singolo o alla lista
- update : /api/users/id
- delete : /api/users/id

### honeypot

- /login : casuale true o false (quello vero è logon)
- /signup

## pagine
- [ ] login (/logon)
- [ ] signup (/register)
- [ ] azienda
    - guardare file azienda.html creato da claude
- [ ] landing page: home
    - guardare file landingPage.html creato da claude
- [ ] shop
    - [ ] index
        - paginazione 20 prodotti per pagina
        - dati da visualizzare per tutti i prodotti:
            - quanti sono disponibili
            - nome
            - descrizione troncata a 20 caratteri
            - prezzo in €
        - pulsante "prenota" che manda alla pagina di dettaglio
    - [ ] detail
        - quanti sono disponibili
        - nome
        - descrizione
        - prezzo
        - form di prenotazione dove va inserita la quantità (minimo 1 massimo il numero di prodotti disponibili)
- [ ] mostra
    - [ ] index
        - paginazione 10 foto per pagina
    - [ ] detail
        - photo
        - title
        - originalTitle
        - year
        - place
        - description
        - state
        - price
        - eventuali pulsanti di prenotazione
        in caso di admin pulsante di conferma di vendita e annullamento prenotazione
        se l'utente che ha prenotato implementare la possibilità di eliminare la prenotazione
- [ ] admin
    - [ ] dashboard
        - link a tutte le altre pagine admin
    - [ ] create photo (form)
    - [ ] delete photo button
    - [ ] edit photo (form)
    - [ ]? index photo con filtri
    - [ ] create product (form)
    - [ ] delete product (button)
    - [ ] edit product (form)
    - [ ]? index product con filtri
    - [ ] index users with collaborator handling (button)

# database

- [ ] products
    - product_id:int,pk
    - available:int
    - booked:int
    - sold:int
    - name:string(255)
    - description:text
    - price:decimal

- [ ] users
    - user_id:int,pk
    - username:string(50),unique (A-9, no space or special character)
    - password:string(8-60),unique (A-9, no space)
    - email:string(100),unique (^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$)
    - verified:timestamp,defaultNull
    - admin:tinyInt(1)
    - collaborator:tinyInt(1)

- [ ] photos
    - photo_id:int,pk
    - path:string(255),unique
    - title:string(100),unique
    - original_title:string(100),unique
    - year:short
    - place:string(100)
    - description:text
    - state:enum(["booked", "sold", "available"])
    - price:decimal
    - booked_by:int,fk(users),nullable

- [ ] sessions
    - session_id:int,pk
    - token:varchar(44) perché sha256 + base64 = 44 byte
    - created:timestamptz DEFAULT NOW()
    - expires:timestamptz DEFAULT NOW() + interval '7 days'
    - user_id:int,fk(users)