# MySQL ja Node.js

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

