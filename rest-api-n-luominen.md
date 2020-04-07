# REST APIt ja Node

## Yleistä

API \(Application Programming Interface\), tarkoittaa käytännössä sovellusrajapintaa, eli niitä komentoja joilla sovellukselta voi pyytää toimintoja tai palveluita. Viime vuosina API-termi on kuitenkin omittu enenevissä määrin viittaamaan nimenomaisesti REST-pohjaisiin rajapintoihin joita käytetään web-sovelluksissa. API:t voidaan nähdä myös sovelluksille suunniteltuina käyttöliittyminä tietojärjestelmiin.

Lähes kaikki verkossa tai mobiililaitteessa ajettavat sovellukset hyödyntävät verkon kautta haettua dataa, oli sitten kyseessä lentojen tai hotellien varaukseen keskittyvä palvelu, uutissivusto tai sääpalvelu. API:t ovat se väylä jonka kautta järjestelmät voivat vaihtaa tarpeellisia tietoja keskenään. Voisi jopa sanoa että API:t pitävät modernin webin ja mobiilisovellukset toiminnassa. API:en ympärille on syntynyt mielenkiintoisia ilmiöitä kuten API-talous sekä Avoin Data \(Open Data\). 

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

![HTTP-operaatiot ja niiden selitykset koodeineen \(https://www.restapitutorial.com/\)](.gitbook/assets/image%20%2814%29.png)

## Node.js ja REST APIt

Node.js sopii erinomaisesti rajapintojen toteuttamiseen palvelimella. Se on paitsi nopea ja tehokas tekemisissään, mutta mahdollisuus luoda helposti reittejä sekä kommunikoida ja välittää JSON-dataa tietokannalle tekevät kehittämisestä melko helppoa.

Aiemmin materiaalissa on jo esitelty oikeastaan kaikki ne toiminnallisuudet mitä tarvitse REST API:n rakentamiseen. Katsotaan seuraavaksi vielä kootusti miten yksinkertainen rajapinta toteutetaan.

![Er&#xE4;&#xE4;n REST-rajapinnan kuvaus UML-muodossa \(L&#xE4;hde: https://firstinfinity.wordpress.com/modeling\_rest\_web\_services/\)](.gitbook/assets/image%20%2816%29.png)

## Luotavan rajapinnan hahmottelua

lorem

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
  res.send("Poisteaan leffa id:llä: " + req.params.id);
});

// Web-palvelimen luonti Expressin avulla
app.listen(8081, function() {
  console.log("Kuunnellaan porttia 8081!");
});

```

## Ohjelman testaus Postmanilla

Kahta ensimmäistä reittiä voitaisiin testata selaimessa. Sen sijaan kahden muun reitin kokeiluun tarvitaan jo muita työkaluja kuin  pelkkää selainta -- selain kun ei osaa tehdä muuta kuin GET ja POST-tyyppisiä HTTP-pyyntöjä.

![Kuva: Ohjelman yhden reitin suoritus selaimessa.](.gitbook/assets/image%20%2815%29.png)

Yksi käytetyimmistä työkaluista REST API:en testauksessa on ohjelma nimeltä Postman. Sen avulla on helppo tehdä erilaisia HTTP-kyselyjä haluttuun osoitteeseen ja seurata myös sieltä saapuvia vastauksia. Komentorivityökaluihin tottuneet käyttävät usein myös CURL-nimistä ohjelmaa. 

### GET

Allaolevassa kuvassa Postman lähettää GET-pyynnön määriteltyyn osoitteeseen ja ohjelman laareunassa näkyy saatu vastaus.

![Kuva: API:n testausta Postmanilla](.gitbook/assets/image%20%2832%29.png)

### POST

Vastaavasti voisimme lähettää POST-tyyppiset pyynnöt vaihtamalla vasemman yläreunan alasvetovalikosta verbiä sekä muokkaamalla URL:iin oikean reitin POST-pyynnölle. Body-välilehdellä on mahdollista määritellä arvo-avainpareja, joilla simuloidaan esim. lomakkeelta lähetettäviä kenttiä ja niiden sisältöjä. Alla API:lle välitetään muuttujat title ja year. Vastauksessa luetaan lähetetyt muuttujat body-parserin avulla ja tulostetaan ne ruudulle.

![Kuva: POST-tyyppisen pyynn&#xF6;n l&#xE4;hett&#xE4;minen.](.gitbook/assets/image%20%2835%29.png)



### DELETE

DELETE-verbin testaamisessa alasvetovalikossa on valittuna DELETE ja osoitteeseen on kirjoitettu poistamisen mahdollistava reitti. Lisäksi reitin perässä on muuttuja, joka luetaan koodissa talteen ja tulostetaan alareunan vastauksessa ruudulle. Tämän parametrin perusteella voidaan tehdä tietokantaan poistopyyntö halutusta tiedosta. 

![Kuva: DELETE-versin](.gitbook/assets/image%20%2837%29.png)

### PUT

Päivitysoperaatio suoriteaan PUT-verbillä ja testataan vielä sitäkin Postmanilla.

![Kuva: PUT-verbin testaaminen Postmanilla.](.gitbook/assets/image%20%2813%29.png)

## Tietokantaoperaatiot

Kun reitit on laadittu on jäljellä vielä kytkeä sopivat tietokantaoperaatiot jokaisen taakse. Esimerkeissä käytetään Mongoosea tietokantaoperaatioiden yksinkertaistamiseen. 



## Pyyntöön vastaaminen

Vastaus ja HTML-koodit



