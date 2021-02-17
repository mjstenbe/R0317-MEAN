# Ympäristömuuttujien hyödyntäminen koodissa

## Yleistä

Kun laaditaan sovelluksia, jotka sisältävät "arkaluontoisia" tietoja kuten käyttäjätunnuksia ja salasanoja sovelluksen käyttämiin tietokantoihin, kannattaa nämä tiedostot tallentaa lähdekoodin ulkopuolelle. Tämän ansiosta lähdekoodin jakaminen verkossa tai paljastuminen vahingossa ei kuitenkaan vuoda salaisuuksia julkisiksi.

## Ympäristömuuttujat

Ympäristömuuttujia voidaan asettaa suoraan käyttöjärjestelmätasolla mutta tavanomaisempaa on luoda ns. **env-tiedosto** johon tarpeelliset muuttujat tallennetaan. Node-sovellus voi sitten lukea tiedot tuosta tiedostosta.

On kuitenkin ensiarvoisen tärkeää pitää huoli siitä, että .env-tiedostoa ei julkaista julkisesti lähdekoodin mukana. Tämän johdosta se usein lisätään ns. .gitignore-tiedostoon, joka jättää sen versionhallinan ulkopuolelle.

## Muuttujien lukeminen tiedostosta

Muuttujien lukemista varten voidaan käyttää sitä varten rakennettua moduulia nimeltä _dotenv._ Asennetaan ensin paketti npm:n avulla:

```text
npm install dotenv
```

Luodaan sitten tekstitiedosto nimeltään .env. Piste tiedoston edessä viittaa siihen, että se on Linux-pohjaisissa järjestelmissä "piilotettu" tiedosto joka ei näy tiedostolistauksessa ilman erityisvalitsimia.

Tiedosto sisältää arvo-avainpareja:

```text
USERID=onni.opiskelija@sci.fi
PASSWD=salainen321
DB_HOST=localhost
DB_USER=root
DB_PASS=demo
```

Node.js sovelluksessa tiedosto luetaan sisään seuraavasti:

```javascript
require('dotenv').config();
```

Tämän jälkeen arkaluontoista dataa sisältäviin muuttujiin voidaan Node-koodissa viitata **process.env**- avainsanaa käyttäen seuraavasti:

```javascript
require('dotenv').config();
// Luodaan yhteys kuvitteelliseen tietokantaan käyttäen tiedostoon tallennettuja tunnuksia
const db = require('db')
db.connect({  
    host: process.env.DB_HOST,  
    username: process.env.DB_USER,  
    password: process.env.DB_PASS
    });

```

Esimerkiksi aiemmin luomamme "kirjautumislomakkeen" if-lause, jossa varmistetaan oikeat tunnukset, voisi näyttää palvelimella .env-tiedostoa hyödyntäen seuraavalta:

```javascript
// Luetaan .env-tiedoston data
require('dotenv').config();

// Uusi POST-tyyppiseen sivupyyntöön reagoiva reitti
app.post("/kirjaudu", function(req, res) {

... // luetaan lomakkeen data

// Jos tunnukset ovat oikeat, ohjataan käyttäjä uuteen reittiin
    if (email === process.env.USERID && 
        pass === process.env.PASSWD) 
            res.redirect("/userpage"); 
});
```



