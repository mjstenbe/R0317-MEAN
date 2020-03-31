# Mongoose ja olioita tietokantaan \(ORM\)

Aiemmin tehdyt tietokantakyselyt osoittivat että niiden kirjoittaminen tuottaa kymmeniä rivejä ns. geneeristä koodia, joka toistuu aina kun tietokantaa halutaan käyttää. Toisteista koodia voidaan välttää kirjoittamalla funktioita ja moduuleita, joiden sisälle kootaan tavanomaisimpia toiminallisuuksia.

Tietokannan käyttöä varten on luotu valmiita kirjastoja jotka nopeuttavat ja helpottavat niiden käyttöä monella tapaa. Näistä tunnetuin lienee Mongoose. Se tarjoaa valmiita funktioita tietokannan käyttöä varten, mutta mahdollistaa myös skeemojen käytön sekä oliopohjaisen tiedon käsittelyn tietokantaoperaatioissa.

fgdfg

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

// Toinen tapa tallentaa olio tietokantaan on käyttää ns. promises-notaatiota
newUser
  .save()
  .catch(err => console.log(err))
  .then(r => console.log("Saved " + r));

```

