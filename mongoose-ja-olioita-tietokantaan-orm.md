# Mongoose ja olioita tietokantaan \(ORM\)

## Yleistä

Aiemmin tehdyt tietokantakyselyt osoittivat että niiden kirjoittaminen tuottaa kymmeniä rivejä ns. geneeristä koodia, joka toistuu aina kun tietokantaa halutaan käyttää. Toisteista koodia voidaan välttää kirjoittamalla funktioita ja moduuleita, joiden sisälle kootaan tavanomaisimpia toiminallisuuksia.

Tietokannan käyttöä varten on myös luotu valmiita kirjastoja jotka nopeuttavat ja helpottavat niiden käyttöä monella tapaa. Näistä tunnetuin lienee [Mongoose](https://mongoosejs.com/). Se tarjoaa valmiita funktioita tietokannan käyttöä varten, mutta mahdollistaa myös skeemojen käytön sekä oliopohjaisen tiedon käsittelyn tietokantaoperaatioissa.

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
  birthday: '2000-12-24'
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
  password: Number,
  birthday: Date
});

// Luodaan uusi tallennettava olio
var newUser = new User({
  username: "mattivirtanen",
  password: 1234,
  birthday: '2000-12-24'
});

// Tallennetaan olio tietokantaan
newUser.save(function(err, user) {
  if (err) return console.log(err);
  console.log(user);
});
```

## Tiedon hakeminen ja kyselyiden tekeminen

Kyselyiden tekeminen tietokantaan tapahtuu samalla tapaa kuin tiedon tallentaminenkin. Ideana on, että User-skeemasta luotu malli \(model\) osaa tallentamisen \(eli save-funktion\) lisäksi myös hakea tietoa kannasta. Tähän voidaan käyttää käytetään **find\(\)** -metodia, joskin Mongoose tarjoaa myös monipuolisempia työkaluja kuten **findById\(\), findOneAndUpdate\(\)** sekä **findOneAndDelete\(\)**. Kaikki metodit on kuvattu [täällä](https://mongoosejs.com/docs/api/model.html#model_Model.find).

Ao. esimerkissä tehdään useampia hakuja tietokantaan käyttäen erilaisia Mongoosen tarjoamia. metodeja

```javascript
// Otetaan moduuli käyttöön
var mongoose = require("mongoose");
var uri =
  "mongodb+srv://dbuser:demopass@cluster0-6tein.mongodb.net/mongoosedemos";

// Yhdistetään tietokantaan
mongoose.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true });

// Määritellään User-niminen Schema, eli tietomalli taulukkoon tallennettavista olioista
const User = mongoose.model("User", {
  username: String,
  password: Number,
  birthday: Date
});

// Haetaan kaikki User-tyyppiset oliot tietokannasta
User.find({}, function(err, results) {
  console.log(results);
});

// Haetaan oliot joissa username=masamainio
User.find({ username: "masamainio" }, function(err, results) {
  console.log(results);
});

// Etsitään queryn määrittelemä olio ja päivitetään se newdata-muuttujan arvoilla
var query = { username: "mattivirtanen" };
var newdata = { username: "Uusi demokäyttäjä", password: 9999 };
// Metodi palauttaa muuttuneen arvon jos new=true, muulloin alkup. arvon
var options = { new: true };

// Ajetaan itse fuktio
User.findOneAndUpdate(
  query,
  newdata,
  options,
  function(err, results) {
    console.log(results);
  }
);

```

## Toimintoja tietomalleihin

Mongoose mahdollistaa myös toiminnallisuuksien luomisen osaksi skeemoja. Näillä saadaan monipuolisuutta ja olio-tyyppistä toiminnallisuutta niiden käyttöön. Ideana on, että esitellään skeema ensin erikseen omaan muuttujaansa - aiemmin se on tehty osana mongoose.model\(\) -komentoa. Tämän jälkeen määritellään skeemaan yksi tai useampia metodeja - aivan kuten olio-ohjelmoinnissa luokalle voidaan tehdä. Tämän jälkeen jokainen tietokannasta haettu olio tai sinne tallennettava olio omaa nämä metodit ja niitä voidaan kutsua tarpeen mukaan.

Alla esimerkki funktion määritellystä osaksi skeemaa.

```javascript
// Otetaan moduulit käyttöön
var mongoose = require("mongoose");
var Schema = mongoose.Schema;

var uri =
  "mongodb+srv://dbuser:demopass@cluster0-6tein.mongodb.net/mongoosedemos";
  
// Määritellään skeema erikseen
var userSchema = new Schema({
  username: String,
  password: Number,
  birthday: Date
});

// Lisätään skeemaan metodit - huomaa, nämä pitää tehdä ennen mongoose.model
// komentoa!
userSchema.methods.sayHi = function() {
  var greeting =
    "Hello, my name is " + this.username + ". I was born on " + this.birthday;
  console.log(greeting);
};

// Määritellään User-niminen Schema, eli tietomalli taulukkoon tallennettavista olioista
const User = mongoose.model("User", userSchema);

// Yhdistetään tietokantaan
mongoose.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true });

// Luodaan uusi tallennettava olio
var newUser = new User({
  username: "fannyfunktio",
  password: 4321,
  birthday: "2000-12-21"
});

// newUser olioilla on nyt funktio sayHi() 
newUser.sayHi();

// Tehdään tietokantahaku. Kaikki palautuvat tiedot ovat User-olioita ja niillä ola sayHi()-metodi

User.find({}, function(err, results) {
    // Käydään tulostaulu läpi ja kutsutaan jokaisen olion sayHi() mteodia
    for (var i = 0; i < results.length; i++) {
    results[i].sayHi();
  }
});
```



