
<p align="center" style="margin-top: 10px;">
<img src="https://github.com/alexxdediu/Grob/blob/main/public/img/logo.png" width="350" > 
 </p><br>
 
## OBIETTIVO DEL PROGETTO
In questo progetto è presente un back-end che implementa il gioco degli scacchi. Il codice è stato realizzato con l'utilizzo di [Node.js](https://nodejs.org/en/) e del modulo <a href="https://www.npmjs.com/package/js-chess-engine">JS-CHESS-ENGINE<a>, necessario per gestire tutti i possibile eventi generati dal utente.
 
Gli obiettivi di realizzazione sono: 
 
Si realizzi un sistema che consenta di gestire il gioco di scacchi. In particolare, il sistema si basa sul un utente (sempre autenticato con JWT) che gioca contro l’intelligenza artificiale. Ci possono essere più partite attive in un dato momento. Un utente può allo stesso tempo partecipare ad una ed una sola partita.
•	Dare la possibilità di creare una nuova partita seguendo <a href="https://www.npmjs.com/package/js-chess-engine">JS-CHESS-ENGINE<a> ; 
 la partita può essere:
1.	Utente contro intelligenza artificiale (IA) scegliendo il livello di difficoltà.
 
•	In particolare, è necessario validare la richiesta di creazione della partita. Per ogni partita viene addebitato un numero di token in accordo con quanto segue:
1.	0.40 all’atto della creazione
2.	0.01 per ogni mossa (anche IA)
3.	Il modello può essere creato se c’è credito sufficiente ad esaudire la richiesta (se il credito durante la partita scende sotto lo zero si può continuare comunque).
 
•	Creare la rotta per effettuare una mossa in una data partita verificando se questa è ammissibile o meno (si consiglia di valutare quanto presente in Board Configuration – JSON)

•	Creare una rotta per verificare le partite svolte riportando se sono state vinte o perse il numero di mosse totali,filtrando anche per data di avvio della partita (si ponga attenzione alla validazione delle date)
 
•	Creare una rotta per valutare lo stato di una data partita (di chi è il turno, se è terminata, scacco, scacco matto,…); una partita si considera chiusa quando:
1.	C’è uno scacco matto.
2. L’utente abbandona.
3.	Per ogni partita vinta al giocatore si dà 1 punto; per ogni partita interrotta -0.5 punti;
 
•	Creare una rotta per restituire lo storico delle mosse di una data partita con la possibilità di esportare in formato JSON
•	Restituire la classifica dei giocatori dando la possibilità di scegliere l’ordinamento ascendente / discendente. Questa rotta è pubblica e non deve essere autenticata.
 
- Le richieste devono essere validate (es. utente che scelga un evento che non esistente).
- Ogni utente autenticato (ovvero con JWT) ha un numero di token (valore iniziale impostato nel seed del database). 
- Nel caso di token terminati ogni richiesta da parte dello stesso utente deve restituire 401 Unauthorized. 
- Prevedere una rotta per l’utente con ruolo admin che consenta di effettuare la ricarica per un utente fornendo la mail ed il nuovo “credito” (sempre mediante JWT).
- I token JWT devono contenere i dati essenziali.
- Il numero residuo di token deve essere memorizzato nel db sopra citato.
- Si deve prevedere degli script di seed per inizializzare il sistema.
- Si chiede di utilizzare le funzionalità di middleware.
- Si chiede di gestire eventuali errori mediante gli strati middleware sollevando le opportune eccezioni.
- Si chiede di commentare opportunamente il codice.

## PROGETTAZIONE
 ### ROTTE
I test degli endpoint sono stati fatti con [POSTMAN](https://www.postman.com/).
Di seguito vengono riportate le possibili richieste:
|ROTTA | BODY | TIPO | 
|---|---|---|
| /signUp |email, pwd  |POST|
| /signIn |email, pwd |POST|
|/boards/newboard/:level |color |POST|
|/boards/:boardid/move |from,to |POST|
|/boards/:boardid?| date (facoltativo) |POST|
|/boards/:boardid| |GET|
|/boards/:boardid/abandoned | |GET|
|/boards/:boardid/history | |GET|
|/boards/:boardid/stopped | state |POST|
|/users/admin |email,credits |PUT|
|/users/ranking | sort |POST|
 

 ### Descrizione delle rotte
 
 > **POST** /signUp
 
 Utilizzando questa rotta è possibile ottenere un [Json Web Token](https://jwt.io/) composto dalla chiave segreta e dai dati inseriti nella request (email,password)
 
  #### Esempio di request
 
 ```
{
    "email": "alex@progettopa.it",
    "pwd": "progettopa"
}
 ```
 #### Esempio di response
 
 ```
{
    "msg": "200, Registrazione effettuata con successo!"
}
  ```
 
 > **POST** /signIn
 
 Utilizzando questa rotta è possibile effettuare il login per ottenere la stringa JWT.

 
  #### Esempio di request
 
 ```
 {
    "email": "carlo@gmail.it",
    "pwd": "carlo"
}
 ```
 #### Esempio di response
 
 Con la response di questa rotta è possibile accedere a tutti i dati associati all'utenza presente nel payload.
 
 ```
{
    "jwt": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImNhcmxvQGdtYWlsLml0IiwicGFzc3dvcmQiOiJjYXJsbyIsInVzZXJpZCI6MSwiaWF0IjoxNjY1OTQxNTg3fQ.NUITaZ1OESppb3_D9Qag2ltqrllJSmGqNnGZBvxine0"
 
}
 ```
 
 
> **POST** /boards/newboard/:level
 
 Utilizzando questa rotta è possibile creare una nuova partita, passando come parametro il livello a cui desidera giocare.
 La descrizione dei livelli di difficoltà è descritta [qui](https://www.npmjs.com/package/js-chess-engine#computer-ai).
 Durante la creazione della partita lo stato viene impostato a 'ip'.

 
  #### Esempio di request
 
 Questo campo indica il colore con cui si vuole iniziare la partita
 
 ```
{
    "color": "white"
}
 ```
 #### Esempio di response
 
La response è un messaggio di conferma/errore di inizio partita.
 
 ```
{
    "msg": "200, Partita iniziata!"
}
 ```
> **POST** /boards/:boardid/move
 
 Utilizzando questa rotta è possibile effettuare un movimento sulla scacchiera.
 I possibili movimenti sono indicati nella [board configuration](https://www.npmjs.com/package/js-chess-engine#board-configuration)

  ### Esempio di request
 
 ```
{
    "from": "F7",
    "to": "E6"
}
 ```
 #### Esempio di response
 
La response è la mossa dell' intelligenza artificiale
 
 ```
{
    "B1": "C1"
}
 ``` 
 
> **POST** /boards/:boardid?
 
 Utilizzando questa rotta è possibile ottenere tutte le partite giocate da un determinato utente ed alcune informazioni.
 I possibili movimenti sono indicati nella [board configuration](https://www.npmjs.com/package/js-chess-engine#board-configuration)

 #### Esempio di request
 Il formato della data deve essere **DD/MM/YYYY**
 ```
{
    date : "12/10/2022"
}
 ```
#### Esempio di response
 
 
 ```
[
    [
        {
            "boardId": 2,
            "player": 3,
            "nMoves": 1,
            "state": "stopped"
        }
    ],
    [
        {
            "boardId": 1,
            "player": 3,
            "nMoves": 23,
            "state": "abandoned"
        }
    ]
]
 ``` 

  > **GET** /boards/:boardid/info
 
 Utilizzando questa rotta è possibile ottenere lo stato di una partita.
 i possibili stati sono ripartati nella [sezione successiva](#stati-di-una-partita)


#### Esempio di response
 
 
 ```
{
    "isOver": false,
    "checkMate": false,
    "check": false,
    "turn": "white",
    "abandoned": false
}
 ```
   > **GET** /boards/:boardid/abandoned
 
 Utilizzando questa rotta è possibile abbandonare una partita, impostando lo stato ad 'abandoned'
 i possibili stati sono ripartati nella [sezione successiva](#stati-della-partita)


#### Esempio di response
 
 
 ```
{
    "msg": "200, la partita è stata abbandonata"
}
 ```
 
 > **POST** /boards/:boardid/stopped
 
 Utilizzando questa rotta è possibile interrompere o riprendere una partita.
 Nel body viene specificato lo stato che può essere 'resume' o 'stopped'
 i possibili stati sono ripartati nella [sezione successiva](#stati-della-partita)

#### Esempio di request

 ```
{
    "state" : "resume"
}
 ```
 
#### Esempio di response
 
 
 ```
{
    "msg": "200, la partita è stata ripresa"
}
 ```
 
  > **GET** /boards/:boardid/history
 
 Utilizzando questa rotta è possibile ottenere lo storico delle mosse di una partita.

#### Esempio di response
 
 
 ```
[
    {
        "from": "B1",
        "to": "C3"
    },
    {
        "from": "G8",
        "to": "F6"
    }
]
 ```
 
 > **POST** /boards/users/ranking
 
 Utilizzando questa rotta è possibile ottenere la classifica dei giocati, passando nel body il tipo di ordinamento.
 L'ordinamento può essere credesce (asc) o descrescente (desc)
 
 #### Esempio di request
 
  ```
 {
    "sort": "asc"
}
  ```

#### Esempio di response 
 ```
[
    {
        "position": 1,
        "player": {
            "id": 3,
            "email": "alex@progettopa.it",
            "wins": 1
        }
    },
    {
        "position": 2,
        "player": {
            "id": 1,
            "email": "carlo@gmail.it",
            "wins": 1
        }
    },
    {
        "position": 3,
        "player": {
            "id": 2,
            "email": "mario@gmail.it",
            "wins": 2
        }
    }
]
 ```
 
 > **PUT** /boards/users/admin
 
 Utilizzando questa rotta è possibile incrementare o descrementare il credito di un utente.
 Questa rotta è accessibile solo se l'utenza è di tipo 'admin'
 
 #### Esempio di request
 
  ```
 {
    "email": "alex@progettopa.it",
    "credits" : 5
}
  ```
 #### Esempio di response
 
  ```
 {
    "msg": "200, La modifica dei crediti è avvenuta con successo"
}
  ```

## STATI DELLA PARTITA
 
Di seguito sono riportati tutti i possibili stati di una partita.
Gli stati di una partita vengono aggiornati in base alle rotte utilizzate.

|STATO | DESCRIZIONE | CODICE | 
|---|---|---|
|Partita in esecuzione |Stato utilizzato durante la creazione di una nuova partita|ip|
|Partita abbandonata |Stato utilizzato per abbandonare una partita  |abandoned|
|Partita interrotta|Stato utilizzato per interrompere una partita |stopped|
|Partita vinta |Stato che indica la vittoria del player|win|
|Partita persa| Stato che indica la vittoria dell'AI |defeat|

 
## DIAGRAMMI UML
 
### DIAGRAMMI DEI CASI D'USO
- Diagramma dei casi d'uso dell'utente:
<p align="center" style="margin-top: 10px;">
<img src="https://github.com/alexxdediu/Grob/blob/main/UML/casi-duso-user.jpg" width="650"> 
 </p>
 
 - Diagramma dei casi d'uso dell'amministratore:
 <p align="center" style="margin-top: 10px;">
<img src="https://github.com/alexxdediu/Grob/blob/main/UML/casi-duso-admin.jpg" width="650"> 
 </p>
 
### DIAGRAMMI DELLE SEQUENZE
 
 - Registrazione
 
  <p align="center" style="margin-top: 10px;">
<img src="https://github.com/alexxdediu/Grob/blob/main/UML/signUp.jpg" width="800" height="280"> 
 </p>
 
 - Accedi
 
  <p align="center" style="margin-top: 10px;">
<img src="https://github.com/alexxdediu/Grob/blob/main/UML/signIn.jpg" width="800" height="280"> 
 </p>
 
  - Nuova partita
 
  <p align="center" style="margin-top: 10px;">
<img src="https://github.com/alexxdediu/Grob/blob/main/UML/newGame.jpg" width="800" height="280"> 
 </p>
 
  - Stato di una partita
 
  <p align="center" style="margin-top: 10px;">
<img src="https://github.com/alexxdediu/Grob/blob/main/UML/infoBoard.jpg" width="800" height="280"> 
 </p>
 
  - Tutte le partite
 
  <p align="center" style="margin-top: 10px;">
<img src="https://github.com/alexxdediu/Grob/blob/main/UML/allBoards.jpg" width="800" height="280"> 
 </p>
 
  - Spostamento sulla scacchiera
 
  <p align="center" style="margin-top: 10px;">
<img src="https://github.com/alexxdediu/Grob/blob/main/UML/pieceMove.jpg" width="800" height="280"> 
 </p>
 
  - Classsifica giocatori
 
  <p align="center" style="margin-top: 10px;">
<img src="https://github.com/alexxdediu/Grob/blob/main/UML/ranking.jpeg" width="800" height="280"> 
 </p>
 
  - Modifica crediti degli utenti
 
  <p align="center" style="margin-top: 10px;">
<img src="https://github.com/alexxdediu/Grob/blob/main/UML/admin.jpg" width="800" height="280"> 
 </p>
 
 In questa sezione non sono stati inseriti tutti i diagrammi, le restanti immagini sono presenti nella cartella [UML](https://github.com/alexxdediu/Grob/blob/main/UML)
 
 ## Design Pattern
 
 ### SINGLETON

Per lo sviluppo dell'applicazione è stato utilizzato il design pattern Singleton che ha lo scopo di garantire che di una determinata classe venga creata una e una sola istanza, e di fornire un punto di accesso globale a tale istanza.
 
 <p align="center" style="margin-top: 10px;">
<img src="https://github.com/alexxdediu/Grob/blob/main/public/img/singleton.png"width="500" height="300"> 
 </p>
 
 ### MC
 
 Per lo sviluppo dell'applicazione è stato utilizzato il pattern M(V)C, che consente di suddividere il progetto in 2 parti:
 
*  Models
*  Controllers

Nei ***models*** sono presenti le classi utilizzare per mappare le tabelle del database, il collegamento avviene con con l'utilizzo dei metodi dell'ORM
[Sequelize](https://sequelize.org/) che vengono attivati su istanze dei model.
I ***controllers*** vengono utilizzati come intermediario tra views e models, in particolare nell'applicazione vengono utilizzati per la gestione delle richieste e delle risposte ottenute utilizzando le rotte. Le classi controller richiamano i metodi utilizzati per mappare i dati nel database e per la creazione dei dati che costituiscono la response.

 <p align="center" style="margin-top: 10px;">
<img src="https://miro.medium.com/max/1000/1*23_6IjYfnybitGq4jO0QCg.gif" width="400" height="300"> 
 </p>
 
 i models utilizzati sono presenti nei file ***board.ts*** e ***users.ts***  e sono stati definiti con ***sequelize.init(modelName, attributes, options)***
 
 #### Esempio model sequelize
 
  ```
  export const board = boards.init({
    id : {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true
    },
    player: {
        type: DataTypes.INTEGER,
    },
    color: {
        type: DataTypes.STRING,
    },
  
    history: {
        type: DataTypes.STRING,
    },
    startdate: {
        type: DataTypes.STRING,

    },

    config: {
        type: DataTypes.STRING,

    },
    level: {
        type: DataTypes.INTEGER,
    },
    state: {
        type: DataTypes.STRING,
    }
   
}, {
    sequelize,
    timestamps:false,
    createdAt: false,
    updatedAt: false,
    modelName: databaseConstants.BOARDS_TABLE
  
})
 ```
Tra i controllers sono presenti gli effettivi controllers e  i file ***auth*** e  ***routes.ts*** che contengono rispettivamente i middleware e le rotte utilizzare

#### Esempio rotta
 
 ```
app.get('/boards/:boardid/stopped', checkEmailJwt, checkBoardId, (req, res) => {
    setBoardState(req, res)
})
  ```

 
 ### Middleware
  Le funzioni middleware sono funzioni con accesso all’oggetto richiesta (req), all’oggetto risposta (res) e alla successiva funzione middleware nel    ciclo richiesta-risposta dell’applicazione. La successiva funzione middleware viene comunemente denotata da una variabile denominata next.
  Nell'applicazione i middleware sono stati utilizzati principalmente per l'autenticazione dell'utente e per la gestione delle eccezioni
  
 <p align="center" style="margin-top: 10px;">
<img src="https://iq.opengenus.org/content/images/2019/08/Add-a-subheading--1-.png" width="700" height="300"> 
 </p>
 

## AVVIO DEL PROGETTO CON DOCKER
 
All'avvio dell'applicazione il database sarà popolato con una tabella ``` users``` con 4 utenti (di cui uno con profilo 'admin)', con email ```alex@progettopa.it```, ```admin@progettopa.it```,```marco@progettopa.it``` e ```carlo@progettopa.it```.
Inoltre sarà presente anche una tabella ```boards``` in cui saranno presenti 5 board, in modo da poter effettuare i test in modo corretto.

per avviare Docker è necessario avviare il docker-compose con il seguente comando

``` docker-compose up ```

Il servizio sarà attivo alla porta 8080.

## Test

Per realizzare i test del progetto è stato inserito il file ``` Grob.postman_collection.json ``` nella repository, che a sua volta dovrà essere importato all'interno di Postman.


## FRAMEWORK/MODULI UTILIZZATI
 
*  [NODEJS](https://nodejs.org/en/docs/guides/anatomy-of-an-http-transaction/)
*  [EXPRESS.JS](https://maven.apache.org/)
*  [SEQUELIZE](https://spring.io/)
*  [DOTENV](https://github.com/motdotla/dotenv)
*  [TS-NODE](https://www.npmjs.com/package/ts-node)
*  [POSTGRES](https://www.npmjs.com/package/postgres)
*  [HTTP-STATUS-CODES](https://www.npmjs.com/package/http-status-codes)
*  [BODY-PARSER](https://www.npmjs.com/package/body-parser)

## AUTORE

**Alexandru Dediu**
 
 
 


