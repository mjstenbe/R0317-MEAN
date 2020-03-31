# Mongoose ja olioita tietokantaan \(ORM\)

## Yleistä

Aiemmin tehdyt tietokantakyselyt osoittivat että niiden kirjoittaminen tuottaa kymmeniä rivejä ns. geneeristä koodia, joka toistuu aina kun tietokantaa halutaan käyttää. Toisteista koodia voidaan välttää kirjoittamalla funktioita ja moduuleita, joiden sisälle kootaan tavanomaisimpia toiminallisuuksia.

Tietokannan käyttöä varten on luotu valmiita kirjastoja jotka nopeuttavat ja helpottavat niiden käyttöä monella tapaa. Näistä tunnetuin lienee [Mongoose](https://mongoosejs.com/). Se tarjoaa valmiita funktioita tietokannan käyttöä varten, mutta mahdollistaa myös skeemojen käytön sekä oliopohjaisen tiedon käsittelyn tietokantaoperaatioissa.

## Asennus ja käyttöönotto

Mongoose otetaan käyttöön asentamalla se npm:llä seuraavasti:

```javascript
npm install mongoose
```

Mongoose otetaan käyttöön Node.js-sovelluksessa tuomalla se require-moduulilla ohjelmaan.

```javascript
// Otetaan moduuli käyttöön
var mongoose = require("mongoose");
```

## Yhdistäminen tietokantaan

Mongoose vähentää tietokannan käyttöön kuluvia koodirivejä huomattavasti.  Alla esimerkki koodista, joka ei tee muuta kuin avaa yhteyden MongoDB-tietokantaan. 

```javascript
// Otetaan moduuli käyttöön
var mongoose = require("mongoose");
// Määritellään yhteysosoite
var uri = "mongodb+srv://dbuser:demopass@cluster0-6tein.mongodb.net/sample_mflix";

// Luodaan yhteys
mongoose.connect(uri);

var db = mongoose.connection;

// Tulostetaan tieto yhteyden onnistumisesta tai virheestä
db.on("error", console.log("Yhteysvirh!:"));

db.once("open", function() {
  console.log("Yhteys on muodostettu!");
});
```

## Skeeman määrittely 

Mongoose on suunniteltu siten, ennen tiedon lisäämistä tietokantaan sille pitää määritellä skeemaa \(eli rakennekuvaus\). Skeema sisältää kentän nimen sekä tyypin, joita Mongoose tuntee 10 erilaista. Alla esimerkki "User"-nimisen skeeman esittelystä koodissa. Skeemojen tietokentistä voit lukea lisää [täältä](https://mongoosejs.com/docs/schematypes.html).

```javascript
// Määritellään User-niminen Schema, eli tietomalli taulukkoon tallennettavista olioista
const User = mongoose.model("User", {
  username: String,
  password: Number,
  birthday: Date
});
```

## Tiedon lisääminen tietokantaan

Tiedon lisääminen tietokantaan tapahtuu luomalla ensin uusi User-tyyppinen olio \(nimeltään **newUser\)**, jonka kenttämäärittelyjen tulee vastata skeemassa kuvattua rakennetta. Edellä luotu olio osaa tallentaa itsensä **newUser.save\(\)**-funktion avulla tietokantaan. Erillistä tietokantafunktiota \(insertOne\) ei tarvitse siis kutsua lainkaan. Save\(\)-funktio saa tuttuun tapaan parametrina anonyymin funktion joka käsittelee joko mahdollisen virhetilanteen \(err\) tai esim. tulostaa tiedon tallennuksen onnistumisesta . 

```javascript
// Luodaan uusi tallennettava olio
var newUser = new User({
  username: "mattivirtanen",
  password: 1234,
  birthday: new Date("24-12-2000")
});

// Tallennetaan olio tietokantaan
newUser.save(function(err, result) {
  if (err) console.log(err);
  console.log("Tallennettu: " + result);
});

```

Toinen mahdollinen tapa on käyttää JavaScriptin uuden version mukanaan tuomaa promises-notaatiota ja ketjuttaa tapahtumien käsittely save\(\) -metodissa hieman selkeämmin auki. 

```javascript
// Toinen tapa tallentaa olio tietokantaan on käyttää ns. promises-notaatiota
newUser
  .save()
  .catch(err => console.log(err))
  .then(r => console.log("Tallennettu " + r));
```

## Esimerkkiohjelma kootusti

Alla esimerkkiohjelma kokonaan. Se siis siis lisää käyttäjän tietoja kuvaavan olion tietokantaan sekä tulostaa tiedon lisäyksen onnistumisesta. 

```javascript
// Otetaan moduuli käyttöön
var mongoose = require("mongoose");
var uri = "mongodb+srv://dbuser:demopass@cluster0-6tein.mongodb.net/mongoosedemos";

// Yhdistetään tietokantaan
mongoose.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true });

// Määritellään User-niminen Schema, eli tietomalli taulukkoon tallennettavista olioista
const User = mongoose.model("User", {
  username: String,
  password: String,
  birthday: Date
});

// Luodaan uusi tallennettava olio
var newUser = new User({
  username: "mattivirtanen",
  password: "demopass"
  // birthday: new Date("24-12-2000")
});

// Tallennetaan olio tietokantaan
newUser.save(function(err, user) {
  if (err) return console.log(err);
  console.log(user);
});
```

