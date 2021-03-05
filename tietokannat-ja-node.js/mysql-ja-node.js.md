# MySQL ja Node.js

## Perusteet

Perinteisten relaatiotietokantojen käyttö Nodella on melko suoriaviivaista. Ensin tulee asentaa moduuli, joka tarjoaa tietokantaoperaatiot ohjelman käyttöön:

```text
npm i mysql
```

Tämän jälkeen koodissa määritellään yhteysosoite sekä käyttäjätunnus ja salasana tietokantaan:

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

