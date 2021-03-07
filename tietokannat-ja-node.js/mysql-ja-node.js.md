# MySQL ja Node.js

## Moduulin asennus

Perinteisten relaatiotietokantojen käyttö Nodella on melko suoriaviivaista. Ensin tulee asentaa moduuli, joka tarjoaa tietokantaoperaatiot ohjelman käyttöön:

```text
npm i mysql
```

Tämän jälkeen koodissa määritellään yhteysosoite sekä käyttäjätunnus ja salasana tietokantaan. Esimerkissä käytän paikalliselle koneelle asennettua MySQL-tietokantaa osana XAMP-asennusta. Näinollen yhteysosoite on localhost ja käyttäjätunnus root. Salasanaa ei ole asetettu.

 **HUOM. Tällaiset arvot ovat tyypillisiä paikallisessa kehitysympäristössä, mutta niitä ei tulisi viedä julkisesti saavutettavissa olevalle palvelimelle.** Lisäksi tunnukset voitaisiin lukea ulkoisesta ENV-tiedostosta, jota on käsitelty jo aiemmin

```javascript
Tuodaan mysql-funktiot ohjelman käyttöön
var mysql = require("mysql");

// Määritellään tietokannan yhteystiedot JSON-muodossa
var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
});
```

## Yhteyden luominen

Lopuksi luodaan yhteys tietokantaan käyttäen connect-funktiota. Tämä ohjelma ei vielä tee mitään, mutta onnistunut yhteydenluonti tuottaa konsoliin tulostuksen "Connected". Muussa tapauksessa konsoliin tulostetaan virheilmoitus.

```javascript
Tuodaan mysql-funktiot ohjelman käyttöön
var mysql = require("mysql");

// Määritellään tietokannan yhteystiedot JSON-muodossa
var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
});
// Luodaan yhteys tietokantaan
con.connect(function (err) {
  if (err) throw err;
  console.log("Connected!");
});
```

## Kyselyn tekeminen

Kyseitä voidaan tehdä query-funktion avulla.

```javascript
Tuodaan mysql-funktiot ohjelman käyttöön
var mysql = require("mysql");

// Määritellään tietokannan yhteystiedot JSON-muodossa
var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
});

// Luodaan yhteys tietokantaan
con.connect(function (err) {
  if (err) throw err;
  
  // Suoritetaan SQL-kysely
  con.query("SELECT * FROM henkilo", function (err, result, fields) {
    if (err) throw err;
    // Tulostetaan kaikki tulosdata
    console.log(result);
    // console.log(result.length);
    // Tulostetaan tulosjoukon viides alkio
    console.log(result[5]);
        // Tulostetaan tulosjoukon viides alkio ja siitä kenttä enimi
    console.log(result[5].enimi);
  });

// Tehdään toinen kysely, jossa WHERE-lohko mukana
  con.query(
    "SELECT * FROM henkilo WHERE kunta = 'Turku'",
    function (err, result) {
      if (err) throw err;
      console.log(result);
    }
  );
});
```

## Sisäänkirjautumisen toteuttaminen

Jatkokehitetään seuraavaksi jo aiemmin toteuttamaamme sisäänkirjautumissovellusta siten, että uuden käyttäjän tiedot tallentuvat tietokantaan ja sisäänkirjautuvan käyttäjän tiedot käydään varmistamassa sieltä.

### Tietokannan valmistelu

Luodaan ensin tietokantaan tietokanta "logindemo" ja taulu "users" jota ohjelma käyttää. Seuraava SQL-lause luo tietokannan ja sinne tarvittavat rakenteet. Tauluun luodaan 3 saraketta: userid, name ja password. Tässä vaiheessa salasana tallennetaan selväkielisenä. **Oikeassa sovelluksessa salasanan tulisi olla aina tallennettu salatussa muodossa, esim. SHA tai BCRYPT-funktion avulla. Näin esim. tietovuotojen sattuessa arkaluontoinen data ei ole heti kaikkien käytettävissä. Tästä lisää hieman tuonnempana.**

```sql
CREATE DATABASE LOGINDEMO;
CREATE TABLE `logindemo`.`users` ( 
    `userid` VARCHAR(30) NOT NULL ,
    `name` VARCHAR(30),
    `password` VARCHAR(50) NOT NULL
    );
```

Luodaan tietokantaan testikäyttäjä kokeilua varten:

```sql
INSERT INTO `users` (`userid`, `name`, `password`) VALUES (
    'onni123@sci.fi', 
    'Onni Opiskelija', 
    'Salasana123'
    );
```

Tietokannasta löytyy tämän jälkeen seuraava rivi:

![](../.gitbook/assets/image%20%2861%29.png)

Syötettävät kentät voidaan salata joko sovellustasolla tai antaa tietokannan tehdä se. ****MySQL:ssä on sisäänrakennettuna joukko HASH-funktioita, joiden avulla tiedon salaus voidaan liittää osaksi INSERT-lausetta. Esim. ylläolevaan INSERT-lauseeseen voitaisiin liittää SHA1-funktio salasanakentän turvaamiseksi:

```sql
INSERT INTO `users` (`userid`, `name`, `password`) VALUES (
    'Seppo@sci.fi', 
    'Seppo Salattu', 
    SHA1('Salainen123')
    );
```

Tietokannasta löytyy tämän jälkeen seuraava rivi, jossa salasanakenttään viety tieto on salattu SHA1-funktiolla:

![](../.gitbook/assets/image%20%2868%29.png)

### Kyselyiden tekeminen

Ohjelmassa tarvitaan karkeasti kahdenlaisia kyselyitä: 1\) Käyttäjän olemassaolon tarkastaminen tietokannasta sekä 2\) Uuden käyttäjän lisääminen tietokantaan. Näistä jälkimmäisen toteuttava SQL-lause on esitelty jo edellä testikäyttäjän luomisen yhteydessä.

Olemassaolevaa käyttäjää haettaisiin tietokannasta ao. kyselyn avulla. Jos haku palauttaa täsmälleen yhden rivin, tiedetään että käyttäjä jonka tunnus ja salasana täsmäävät löytyvät järjestelmästä. 

Jos tietoja ei löydy, on joko tunnus tai salasana väärin tai käyttäjää ei ole järjestelmässä. Se mikä näistä aiheuttaa kirjautumisen epäonnistumisen jää vain järjestelmän tietoon - kirjautumista yrittävälle taholle tätä ei tietoturvasyistä kannata kertoa.

```sql
SELECT * FROM USERS WHERE userid = 'Onni123' and password='Salasana123';
```

### Lomakedatan lukeminen 

Otetaan käyttöön jo aiemmin kehitelty sisäänkirjautumislomakkeen tarjoava koodi. Siellä tutkimme lomakkeen lähettämiä tietoja if-lauseen sisällä seuraavasti:

```javascript
// Uusi POST-tyyppiseen sivupyyntöön reagoiva reitti
app.post("/kirjaudu", function (req, res) {
  console.log(req.body);
  var email = req.body.email;
  var pass = req.body.pass;

  // Jos tunnukset ovat oikeat, ohjataan käyttäjä uuteen reittiin
  if (email === "onni@sci.fi" && pass === "opiskelija") {
    res.redirect("/userpage");
  }
});
```

Muutetaan koodia siten, että lomakkeelle syötettyjä tietoja yritetään etsiä tietokannasta. Ensin muodostetaan SQL-lause lomakkeen tiedoista:

```javascript
  var email = req.body.email;
  var pass = req.body.pass;
  var query = `SELECT * FROM users WHERE userid = '${email}' and password='${pass}';`;
```

Sitten käydään tekemässä tietokantahaku ja tutkitaan if-lauseella palautuiko sieltä rivejä näillä tunnuksilla. Jos rivejä on 1, tunnus löytyy järjestelmästä ja käyttäjä voidaan ohjata uudelle sivulle \(userpages\). Muutoin ohjataan käyttäjä takaisin lomakkeelle \(/\).

```javascript
con.connect(function (err) {
    if (err) throw err;
    con.query(query, function (err, result, fields) {
      // Tulostetaan konsoliin tulosrivit 
      console.log("Tulosrivien määrä: " + result.length);
      // Jos meni oikein, tuloksia on 1 ohjataan käyttäjä toiseen paikkaan
      if (result.length == 1) {
        res.redirect("/userpage");
        console.log("Tunnukset oikein!");
      } else {
        res.redirect("/");
        console.log("Väärät tunnukset tai käyttäjää ei löydy");
      }
    });
  });
```

Kokonaisuudessaan ohjelma vielä alla. Sen alkuun lisäsin mysql-moduulin tuontilause sekä tietokannan yhteystiedot. 

```javascript
// Otetaan express-moduuli käyttöön
var express = require("express");
// Otetaan body-parser -moduuli käyttöön
var bodyParser = require("body-parser");

var app = express();

// Tarjoillaan staattisia sivuja tästä hakemistosta
app.use(express.static("./"));

// create application/x-www-form-urlencoded parser
app.use(bodyParser.urlencoded({ extended: true }));

var mysql = require("mysql");

var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "logindemo",
});

// Uusi POST-tyyppiseen sivupyyntöön reagoiva reitti
app.post("/kirjaudu", function (req, res) {
  var email = req.body.email;
  var pass = req.body.pass;
  var query = `SELECT * FROM users WHERE userid = '${email}' and password='${pass}';`;

// Luodaan tietokantayhteys
  con.connect(function (err) {
    con.query(query, function (err, result, fields) {
      if (err) {
        console.log("Tapahtui virhe!" + err);
      }
      console.log("Tulosrivien määrä: " + result.length);
      if (result.length == 1) {
        res.redirect("/userpage");
        console.log("Tunnukset oikein!");
      } else {
        res.redirect("/");
        console.log("Väärät tunnukset tai käyttäjää ei löydy");
      }
    });
  });
});
// Uusi reitti sisäänkirjautuneelle käyttäjälle.
app.get("/userpage", function (req, res) {
  res.send("You are now logged in!");
});

// Oletusreitti joka tarjoillaan, mikäli muihin ei päädytty.
app.get("*", function (req, res) {
  res.send("Cant find the requested page", 404);
});

// Web-palvelimen luonti Expressin avulla
app.listen(3000, function () {
  console.log("Listening to port 3000.");
});

```

### Modularisointia

Koodi kasvaa melko nopeasti hallitsemattomaksi puuroksi. Sitä voidaan modularisoida esim. tekemällä operaatioista erillisiä funktiotia. Nodessa erillisistä "vastuista" on tapana tehdä moduuleita ja tallentaa koodi omaan tiedostoonsa. Katsotaan tästä esimerkki.

### Tietokantafunktiot omaan moduuliin

Siirretään ensin kaikki tietokannan käsittelyyn liittyvä koodi omaan tiedostoonsa nimeltä db.js. Moduulin sisälle luodaan anonyymifunktio, joka nimetään select-muuttujaksi ja exportataan se. Näin funktiota voidaan käyttää muualtakin.

```javascript
// db.js 
var mysql = require("mysql");

var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "logindemo",
});

// Tehdään hakutoiminnosta oma funktio

exports.select = function (req, res, query) {
  console.log("Selectissä" + query);
  con.connect(function (err) {
    con.query(query, function (err, result, fields) {
      if (err) {
        console.log("Tapahtui virhe!" + err);
      }
      console.log("Tulosrivien määrä: " + result.length);
      if (result.length == 1) {
        res.redirect("/userpage");
        console.log("Tunnukset oikein!");
      } else {
        res.redirect("/");
        console.log("Väärät tunnukset tai käyttäjää ei löydy");
      }
    });
  });
};
```

Tämän jälkeen itse palvelimen koodi muuttuu aika lyhyeksi. Ohjelmaan tuodaan mukaan äsken kirjoittamme moduuli db.js require-funktiolla, eli samalla tapaa kuin muutkin valmiskirjastot  

```javascript
var DB = require("./db.js");
```

Tämän jälkeen select -funktiota voidaan kutsua require-funktiossa esitellyn DB-muuttujan kautta.

```javascript
  DB.select(query);
```

Reitti joka käsittelee kirjautumisen muuttuu seuraavanlaiseksi:

```javascript
app.post("/kirjaudu", function (req, res) {
  var email = req.body.email;
  var pass = req.body.pass;
  var query = `SELECT * FROM users WHERE userid = '${email}' and password='${pass}';`;
  
 // Kutsutaan DB-moduulin select -funktiota
   DB.select(req, res, query);
});
```

Palvelimen koodi kokonaisuudessaan:

```javascript
// Otetaan express-moduuli käyttöön
var express = require("express");
// Otetaan body-parser -moduuli käyttöön
var bodyParser = require("body-parser");

var app = express();

// Tarjoillaan staattisia sivuja tästä hakemistosta
app.use(express.static("./"));

// create application/x-www-form-urlencoded parser
app.use(bodyParser.urlencoded({ extended: true }));

// Tuodaan tietokantamoduuli ohjelmaan mukaan
var DB = require("./db.js");

// Uusi POST-tyyppiseen sivupyyntöön reagoiva reitti
app.post("/kirjaudu", function (req, res) {
  var email = req.body.email;
  var pass = req.body.pass;
  var query = `SELECT * FROM users WHERE userid = '${email}' and password='${pass}';`;
  DB.select(req, res, query);
});
// Uusi reitti sisäänkirjautuneelle käyttäjälle.
app.get("/userpage", function (req, res) {
  res.send("You are now logged in!");
});

// Oletusreitti joka tarjoillaan, mikäli muihin ei päädytty.
app.get("*", function (req, res) {
  res.send("Cant find the requested page", 404);
});

// Web-palvelimen luonti Expressin avulla
app.listen(3000, function () {
  console.log("Listening to port 3000.");
});

```

Oikeastaan koko muuttujien lukemisen ja query-muuttujan koostamisen voisi siirtää DB-moduuliin. Tämän jälkeen reittiin jää vain yksi komento. Koska parametri rakennetaan siellä, ei query -muuttujaa tarvitse enää välittää edelleen. Sen sijaan req ja res muuttujat tarvitaan jotta niihin voidaan kirjoittaa vastaus.

```javascript
app.post("/kirjaudu", function (req, res) {
  DB.select(req, res);
});
```

Alla palvelimen  koodi kokonaisuudessaan:

```javascript
// Otetaan express-moduuli käyttöön
var express = require("express");
// Otetaan body-parser -moduuli käyttöön
var bodyParser = require("body-parser");

var app = express();

// Tarjoillaan staattisia sivuja tästä hakemistosta
app.use(express.static("./"));

// create application/x-www-form-urlencoded parser
app.use(bodyParser.urlencoded({ extended: true }));

var DB = require("./db.js");

// Uusi POST-tyyppiseen sivupyyntöön reagoiva reitti
app.post("/kirjaudu", function (req, res) {
  DB.select(req, res);
});
// Uusi reitti sisäänkirjautuneelle käyttäjälle.
app.get("/userpage", function (req, res) {
  res.send("You are now logged in!");
});

// Oletusreitti joka tarjoillaan, mikäli muihin ei päädytty.
app.get("*", function (req, res) {
  res.send("Cant find the requested page", 404);
});

// Web-palvelimen luonti Expressin avulla
app.listen(3000, function () {
  console.log("Listening to port 3000.");
});

```

Tietokantamooduuli \(db.js\):

```javascript
// db.js 
var mysql = require("mysql");
var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "logindemo",
});

// Tehdään hakutoiminnosta oma funktio

exports.select = function (req, res, query) {
  // Luetaan muuttujat lomakkeelta
  var email = req.body.email;
  var pass = req.body.pass;
  var query = `SELECT * FROM users WHERE userid = '${email}' and password='${pass}';`;

  con.connect(function (err) {
    con.query(query, function (err, result, fields) {
      if (err) {
        console.log("Tapahtui virhe!" + err);
      }
      console.log("Tulosrivien määrä: " + result.length);
      if (result.length == 1) {
        res.redirect("/userpage");
        console.log("Tunnukset oikein!");
      } else {
        res.redirect("/");
        console.log("Väärät tunnukset tai käyttäjää ei löydy");
      }
    });
  });
};

```

Moduulitiedostot tallennetaan usein alihakemistoon nimeltä modules.

### Tietoturva-asiaa ja salasanan "salaaminen"



