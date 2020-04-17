# REST APIt ja Node

## Yleistä

API \(Application Programming Interface\), tarkoittaa käytännössä sovellusrajapintaa, eli niitä komentoja joilla sovellukselta voi pyytää toimintoja tai palveluita. Viime vuosina API-termi on kuitenkin omittu enenevissä määrin viittaamaan nimenomaisesti REST-pohjaisiin rajapintoihin joita käytetään web-sovelluksissa. API:t voidaan nähdä myös sovelluksille suunniteltuina käyttöliittyminä tietojärjestelmiin.

Lähes kaikki verkossa tai mobiililaitteessa ajettavat sovellukset hyödyntävät verkon kautta haettua dataa, oli sitten kyseessä lentojen tai hotellien varaukseen keskittyvä palvelu, uutissivusto tai sääpalvelu. API:t ovat se väylä jonka kautta järjestelmät voivat vaihtaa tarpeellisia tietoja keskenään. Voisi jopa sanoa että API:t pitävät modernin webin ja mobiilisovellukset toiminnassa. API:en ympärille on syntynyt mielenkiintoisia ilmiöitä kuten API-talous sekä Avoin Data \(Open Data\). 

Katso [video: YouTubesta](https://www.youtube.com/watch?v=s7wmiS2mSXY), jossa esitellään API:en toimintaidea.

{% embed url="https://www.youtube.com/watch?v=s7wmiS2mSXY" %}

Alla olevassa taulukossa on koottu esimerkkejä verkosta löytyvistä avoimista rajapinnoista, jotka tarjoavat dataa halukkaille. Kattavia listoja avoimista apeista löytyy mm. [täältä](https://github.com/public-apis/public-apis).

| Kehittäjä | Osoite | Sisältö |
| :--- | :--- | :--- |
| Spotify API | [https://developer.spotify.com/web-api/](https://developer.spotify.com/web-api/
) | Kaikki palvelun musiikkidata |
| HSL | [https://www.hsl.fi/en/opendata](https://www.hsl.fi/en/opendata
) | Aikataulut ja liikennedata, reittiopas |
| OpenWeatherMap  | [https://openweathermap.org/api](https://openweathermap.org/api) | Globaali säädata |
| Lufthansa Open | [https://developer.lufthansa.com/docs](https://developer.lufthansa.com/docs
) | Lufthansan lentodata |

## REST

Käytännössä REST \(Representational State Transfer\) on tapa järjestää sovellusten välinen kommunikointi Internetissä selaintenkin käyttämää, melko yksinkertaista HTTP-protokollaa käyttäen. 

REST:issä on kyse resursseista ja resurssien operoinnista HTTP-metodien avulla. Resursseja käsitellään protokollan tarjoamilla metodeilla, joista käytetyimmät ovat GET, POST, DELETE, UPDATE, PATCH. 

Yksinkertaistettuna näitä metodeja voisi verrata tietokannan käsittelyyn liittyviin CRUD \(create, read, update, delete\) komentoihin. Esimerkiksi selaintenkin sivupyynnöissä käyttämä HTTP:n GET pyyntö osoitteeseen [http://api.example.com/users](http://api.example.com/users)  voisi palauttaa listan järjestelmän tietokantaan tallennetuista käyttäjistä. 

Vastaavasti HTTP:n POST-komennolla käyttäjän tiedot voidaan lähettää XML tai JSON formaatissa osoitteeseen [http://api.example.com/addusers](http://api.example.com/users), joka puolestaan luo niiden pohjalta tietokantaan uuden käyttäjän. 

DELETE-metodilla voitaisiin poistaa käyttäjä yksilöimällä käyttäjän tunniste osana pyyntöä \(esim. [http://api.example.com/api/delete/2](http://127.0.0.1:8081/api/delete/2
)\) ja PUT sekä PATCH tarjoavat keinon olemassaolevan datan päivittämiseen. 

Resurssi ja sen perässä mahdollisesti olevat tarkenteet kertovat siis kohteen, jota käsitellään ja käytetty HTTP-metodi kertoo, mitä tuolle kohteelle tehdään. Allaolevaan taulukkoon on koottu HTTP-verbit sekä niiden kuvaukset. Lisäksi siitä on nähtävissä palautuskoodit, joita HTTP-protokolla käyttää tiedottaessaan pyynnön lähettäjää operaation onnistumisesta.

![HTTP-operaatiot ja niiden selitykset koodeineen \(https://www.restapitutorial.com/\)](.gitbook/assets/image%20%2816%29.png)

## Node.js ja REST APIt

Node.js sopii erinomaisesti rajapintojen toteuttamiseen palvelimella. Se on paitsi nopea ja tehokas tekemisissään, mutta mahdollisuus luoda helposti reittejä sekä kommunikoida ja välittää JSON-dataa tietokannalle tekevät kehittämisestä melko helppoa.

Aiemmin materiaalissa on jo esitelty oikeastaan kaikki ne toiminnallisuudet mitä tarvitse REST API:n rakentamiseen. Katsotaan seuraavaksi vielä kootusti miten yksinkertainen rajapinta toteutetaan.

![Er&#xE4;&#xE4;n REST-rajapinnan kuvaus UML-muodossa \(L&#xE4;hde: https://firstinfinity.wordpress.com/modeling\_rest\_web\_services/\)](.gitbook/assets/image%20%2818%29.png)

## Luotavan rajapinnan hahmottelua

Hahmotellaan ensin luotava rajapinta reittien ja niissä käytettyjen verbien mukaan:

![Kuva: Luotavan rajapinnan hahmottelua.](.gitbook/assets/image%20%2824%29.png)

## Reittien luominen

Reittien luominen API:a varten on tutua jo aiemmista Expressiltä tehdyistä sovelluksista. Kaksi ensimmäistä reittiä perustuvat tuttuihin GET ja POST -verbeihin. Sen sijaan kaksi jälkimmäistä reittiä toteuttavat PUT \(tiedon päivitys\) ja DELETE operaatiot, joita ei aiemmin tässä materiaalissa ole hyödynnetty. Niiden kohdalla reitin perään lisätään merkintä **:id** joka kuvaa vaihtuvaa parametria reitin osana. Tämä parametri voidaan lukea koodissa talteen \(req.params.id -muuttuja\) ja esim. päivitys tai poisto-operaatio tehdään sen perusteella. 

```javascript
// Otetaan express-moduuli käyttöön
var express = require("express");
var app = express();

// Tämä tarvitaan lomakedatan lukemista varten
var bodyParser = require("body-parser");
app.use(bodyParser.urlencoded({ extended: true }));

// Luodaan reitit ja niiden toiminnallisuudet

// Tulostetaan kaikki leffat
app.get("/api/leffat", function(req, res) {
  res.send("Tulostetaan kaikki leffat.");
});

// Lisätään yksi leffa - huomaa POST-muuttujien lukeminen
app.post("/api/lisaa", function(req, res) {
  res.send("Lisätään leffa: " + req.body.title + " (" + req.body.year + ")");
});

// Muokataan leffan tietoja id-numeron perusteella. Huomaa ID-arvon lukeminen
app.put("/api/muokkaa/:id", function(req, res) {
  res.send("Muokataan leffaa id:llä: " + req.params.id);
});

// Poistetaan leffa id:n perusteella. Huomaa ID-arvon lukeminen 
app.delete("/api/poista/:id", function(req, res) {
  res.send("Poistetaan leffa id:llä: " + req.params.id);
});

// Web-palvelimen luonti Expressin avulla
app.listen(8081, function() {
  console.log("Kuunnellaan porttia 8081!");
});

```

## Ohjelman testaus Postmanilla

Kahta ensimmäistä reittiä \(GET ja POST\) voitaisiin testata selaimessa. Sen sijaan kahden muun reitin kokeiluun tarvitaan jo muita työkaluja -- selain kun ei osaa tehdä muuta kuin GET ja POST-tyyppisiä HTTP-pyyntöjä.

![Kuva: Ohjelman GET-reitin testausta selaimessa.](.gitbook/assets/image%20%2817%29.png)

Yksi käytetyimmistä työkaluista REST API:en testauksessa on ohjelma nimeltä Postman. Sen avulla on helppo tehdä erilaisia HTTP-kyselyjä haluttuun osoitteeseen ja seurata myös sieltä saapuvia vastauksia. Ohjelman saat ladattua [täältä](https://www.postman.com/downloads/). Komentorivityökaluihin tottuneet käyttävät usein myös CURL-nimistä ohjelmaa. Se on [saatavilla myös Windowsille](https://curl.haxx.se/windows/). 

### GET

Allaolevassa kuvassa Postman lähettää GET-pyynnön määriteltyyn osoitteeseen ja ohjelman laareunassa näkyy saatu vastaus.

![Kuva: API:n testausta Postmanilla](.gitbook/assets/image%20%2839%29.png)

### POST

Vastaavasti voisimme lähettää POST-tyyppiset pyynnöt vaihtamalla vasemman yläreunan alasvetovalikosta verbiä sekä muokkaamalla URL:iin oikean reitin POST-pyynnölle. Body-välilehdellä on mahdollista määritellä arvo-avainpareja, joilla simuloidaan esim. lomakkeelta lähetettäviä kenttiä ja niiden sisältöjä. Alla API:lle välitetään muuttujat title ja year. Vastauksessa luetaan lähetetyt muuttujat body-parserin avulla ja tulostetaan ne ruudulle.

![Kuva: POST-tyyppisen pyynn&#xF6;n l&#xE4;hett&#xE4;minen.](.gitbook/assets/image%20%2842%29.png)

### DELETE

DELETE-verbin testaamisessa alasvetovalikossa on valittuna DELETE ja osoitteeseen on kirjoitettu poistamisen mahdollistava reitti. Lisäksi reitin perässä on muuttuja, joka luetaan koodissa talteen ja tulostetaan alareunan vastauksessa ruudulle. Tämän parametrin perusteella voidaan tehdä tietokantaan poistopyyntö halutusta tiedosta. 

![Kuva: DELETE-version testaamista Postmanilla.](.gitbook/assets/image%20%2844%29.png)

### PUT

Päivitysoperaatio suoriteaan PUT-verbillä ja testataan vielä sitäkin Postmanilla.

![Kuva: PUT-verbin testaaminen Postmanilla.](.gitbook/assets/image%20%2815%29.png)

## Tietokantaoperaatiot

Kun reitit on laadittu on jäljellä vielä kytkeä sopivat tietokantaoperaatiot jokaisen taakse. Esimerkeissä käytetään Mongoosea tietokantaoperaatioiden yksinkertaistamiseen. Ohjelmaan  lisätään aluksi Mongoosen vaatima moduuli sekä tietokannan yhdistämiseen tarvittavat muuttujat. **Huomaa erityisesti uutena asiana se, kuinka haku tehdään olemassaolevaan "movies" kokoelmaan. Kokoelman nimi määritellään ao. koodissa skeemassa, rivillä 17.** Kun haku tehdään olemassaolevaan dataan ei skeeman rakenteella ole juurikaan merkitystä.

```javascript
// Otetaan moduuli käyttöön
var mongoose = require("mongoose");
var uri =
  "mongodb+srv://dbuser:demopass@cluster0-6tein.mongodb.net/sample_mflix";

// Yhdistetään tietokantaan
mongoose.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true });

// Määritellään Schema, eli tietomalli.
const Movie = mongoose.model(
  "Movie",
  {
    title: String,
    year: Number,
    poster: String,
  },
  "movies"  // HUOM. Kohdistetaan skeeman operaatiot tähän kokoelmaan
);
```

### Leffojen hakeminen - GET

Ensimmäinen reitti on suoraviivainen, koska sen tarkoitus on hakea kaikki tietokannassa olevat elokuvat ja palauttaa ne ruudulle. Käytännössä tämä saadaan aikaiseksi suorittamalla tietokantaan find\(\)-operaatio ja tulostamalla hakutulokset ruudulle. Koska tietokannasta saatu data on jo valmiiksi JSON-muotoista, se voidaan välittää sellaisenaan selaimelle.

**Huomaa uutena asiana ao. koodissa se, miten res.send\(\) funktion sijaan vastauksen lähettämiseen käytetään res.json\(\) -funktiota**. Tämä lähettää vastauksen selaimelle kuten send-funktiokin, mutta se asettaa vastauksen otsaketietoihin sisältötyypin \(Content-type\) vastaamaan JSON-muotoa \(application/json\). **Toisena uutena asiana vastauksessa lähetetään myös HTTP:n tilakoodi, joka kertoo pyynnön onnistuneen \(200\).** Tämä on itseasiassa se koodi, jota selaimen AJAX-koodissa tutkitaan onnistuneen pyynnön seurauksena.

```javascript
// Tulostetaan kaikki leffat
app.get("/api/leffat", function (req, res) {
   Movie.find({}, function(err, results) {  
    // Lähetetään tietokannan tulokset selaimelle JSON-tyyppisenä ja tilakoodin kanssa
    res.json(results, 200);
  });
});
```

Pienenä hienosäätönä edelliseen koodiin voitaisiin toteuttaa vielä esim. virhetilanteiden käsittely sekä tulosjoukon rajoittaminen. Nyt tietokannassa on 23 564 elokuvaa, mikä tarkoittaa että niiden hakeminen ja lähettäminen selaimelle kestää melko kauan. 

Allaolevassa koodissa tietokantahakuun on lisätty rajoitus, joka palauttaa vain 20 tulosta. Lisäksi jos tietokantahaku päättyy virheeseen, lähetetään siitä virhekoodi 500 \(Internal Server Error\) myös rajapinnan käyttäjälle. Lista kaikista HTTP-virhekoodeista löytyy [täältä](https://www.restapitutorial.com/httpstatuscodes.html).  Mongoosen Find\(\) -funktion hyväksymät parametrit löytyvät [dokumentaatiosta](%20https://mongoosejs.com/docs/api.html#model_Model.find).

```javascript
// Tulostetaan kaikki leffat
app.get("/api/leffat", function (req, res) {
   Movie.find({}, null, { limit: 20 }, function (err, results) {
    // Jos tietokantahaussa tapahtuu virhe, palautetaan virhekoodi myös selaimelle
    if (err){
     res.json("Järjestelmässä tapahtui virhe", 500);
    }
    // Muuten lähetetään tietokannan tulokset selaimelle 
   else {
     res.json(results, 200);
    }
  });
});
```

Tämän reitin testaaminen Postmanilla näyttää seuraavalta:

![Kuva: Reitin testaaminen Postmanilla. ](.gitbook/assets/image%20%2831%29.png)

### Leffojen poistaminen - DELETE

Leffojen poistaminen tapahtuu välittämällä reitin mukana koodiin jokin tunniste, jonka perusteella tietoja voidaan poistaa. Tunnisteen muoto riippuu toki taustajärjestelmästä ja datasta joka sinne on tallennettu. Näissä esimerkeissä käytetyn elokuvadatan tietueet yksilöivä **\_id -kenttä** näyttää Compass-työkalussa seuraavalta:

![Kuva: MongoDB Compassin n&#xE4;kym&#xE4; elokuvadatasta.](.gitbook/assets/image%20%283%29.png)

Pohtimisen arvoinen seikka on myös se, tulisiko DELETE-operaation käyttäjältä vaatia jonkinlainen kirjautuminen tai tunniste ettei sitä käytetä asiattomasti. Tämä jätetään kuitenkin huomioimatta esimerkeissä.

Yksinkertaistetu versio poisto-operaation toteuttavasta reitistä näyttäisi seuraavalta. Kun id on saatu poimittua API:n kutsusta välitetään se Mongoosen findByIdAndDelete\(\) -funktiolle. Mikäli virheitä ei tapahtu, kyseinen alkio poistetaan kannasta ja käyttäjälle lähetetään siitä viesti selaimelle onnistumisesta kertovan tilakoodin \(200\) kera. 

```javascript
// Poistetaan leffa id:n perusteella
app.delete("/api/poista/:id", function (req, res) {
  // Poimitaan id talteen ja välitetään se tietokannan poisto-operaatioon
  var id = req.params.id;

  Movie.findByIdAndDelete(id, function (err, results) {
      res.json("Deleted " + id + " " + results.title, 200);
    }
  });
});
```

Poisto-operaatiossakin saattaa tapahtua muutamia erikoistilanteita. Näitä voisivat olla esim. tietokantayhteyteen liittyvät ongelmat sekä esim. se ettei poistettavaa alkiota löydy tietokannasta. Se miten poikkeustilanteista viestiään APIn käyttäjälle on aina sopimuskysymys, mutta alla yksi yleisluontoinen ratkaisu. Siinä varaudutaan edellä kuvattuihin virheilanteisiin kahdella if-haaralla.

```javascript
// Poistetaan leffa id:n perusteella
app.delete("/api/poista/:id", function (req, res) {
  // Poimitaan id talteen ja välitetään se tietokannan poisto-operaatioon
  var id = req.params.id;

  Movie.findByIdAndDelete(id, function (err, results) {
      // Tietokantavirheen käsittely 
      if (err) {
       console.log(err);
       res.json("Järjestelmässä tapahtui virhe.", 500);
    } // Tietokanta ok, mutta poistettavaa ei löydy. Onko kyseessä virhe vai ei on semantiikkaa
      else if (results == null) {
       res.json("Poistetavaa ei löytynyt.", 200);
    } // Viimeisenä tilanne jossa kaikki ok
      else {
      console.log(results);
      res.json("Deleted " + id + " " + results.title, 200);
    }
  });
});
```

Lopuksi vielä testataan luotu reitti Postmanilla:

![Kuva. Onnistuneen poiston testaus Postmanilla.](.gitbook/assets/image%20%281%29.png)

Mikäli sama alkio yritetään poistaa uudelleen, saadaan seuraava ilmoitus: 

![](.gitbook/assets/image%20%2828%29.png)

### PUT ja POST

Tiedon lisäys- ja poistoreittien toteutus jätetään opiskelijoille itsenäiseksi harjoitukseksi. Edellä läpikäytyjen esimerkkien saattelemana uskoisin että se onnistuu ilman suuria ponnistuksia.

