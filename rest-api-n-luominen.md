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

![HTTP-operaatiot ja niiden selitykset koodeineen \(https://www.restapitutorial.com/\)](.gitbook/assets/image%20%2812%29.png)

## Node.js ja REST APIt

Node.js sopii erinomaisesti rajapintojen toteuttamiseen palvelimella. Se on paitsi nopea ja tehokas tekemisissään, mutta mahdollisuus luoda helposti reittejä sekä kommunikoida ja välittää JSON-dataa tietokannalle tekevät kehittämisestä melko helppoa.

Aiemmin materiaalissa on jo esitelty oikeastaan kaikki ne toiminnallisuudet mitä tarvitse REST API:n rakentamiseen. Katsotaan seuraavaksi vielä kootusti miten yksinkertainen rajapinta toteutetaan.

![Er&#xE4;&#xE4;n REST-rajapinnan kuvaus UML-muodossa \(L&#xE4;hde: https://firstinfinity.wordpress.com/modeling\_rest\_web\_services/\)](.gitbook/assets/image%20%2813%29.png)

## Luotavan rajapinnan hahmottelua

lorem

## Reittien luominen

## Tietokantaoperaatiot

## Pyyntöön vastaaminen



