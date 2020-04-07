# REST APIt ja Node

## Yleistä

API \(Application Programming Interface\), tarkoittaa käytännössä sovellusrajapintaa, eli niitä komentoja joilla sovellukselta voi pyytää toimintoja tai palveluita. Viime vuosina API-termi on kuitenkin omittu enenevissä määrin viittaamaan nimenomaisesti REST-pohjaisiin rajapintoihin joita käytetään web-sovelluksissa, esimerkiksi API-taloudesta puhuttaessa. API:t voidaan nähdä myös sovelluksille suunniteltuina käyttöliittyminä tietojärjestelmiin.

Lähes kaikki verkossa tai mobiililaitteessa ajettavat sovellukset hyödyntävät verkon kautta haettua dataa, oli sitten kyseessä peli, uutissivusto tai sääpalvelu. API:t ovat se väylä jonka kautta järjestelmät voivat vaihtaa tarpeellisia tietoja keskenään. Voisi jopa sanoa että API:t pitävät modernin webin ja mobiilisovellukset toiminnassa. Kun puhutaan[ avoimesta datasta](https://blog.digia.com/avoin-data-julkinen-sektori) niin REST API:t ovat se konkreettinen infrastruktuuri, jonka avulla dataa voidaan hyödyntää ja siirtää paikasta toiseen.

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

REST:issä on kyse resursseista ja resurssien operoinnista http-metodien avulla. Resurssi on se /-kauttaviivalla erotettu osa URL:ia joka tulee domain nimen jälkeen. Vaikkapa siis mielikuvituksellinen lista käyttäjistä [http://api.example.com/users](http://api.example.com/users) jossa /users on se varsinainen manipuloitava resurssi. Resursseja käsitellään HTTP-protokollan tarjoamilla metodeilla, joista käytetyimmät ovat GET, POST, DELETE, UPDATE, PATCH. 

Yksinkertaistettuna noita metodeja voisi verrata tietokannan CRUD \(create, read, update, delete\) komentoihin. Esimerkiksi pyyntö HTTP:n GET [http://api.example.com/users](http://api.example.com/users)  voisi palauttaa listan käyttäjistä. 

Vastaavasti lähettämällä HTTP:n POST-komennolla käyttäjän tiedot vaikkapa XML tai JSON formaatissa samaiseen osoitteeseen voitaisiin luoda uusi käyttäjä. 

DELETE-metodilla voitaisiin poistaa käyttäjä yksilöimällä käyttäjän tunniste pyynnön osoitteessa ja niin edelleen. Resurssi ja sen perässä mahdollisesti olevat tarkenteet kertovat siis kohteen, jota käsitellään ja käytetty HTTP-metodi kertoo, mitä tuolle kohteelle tehdään.

![Er&#xE4;&#xE4;n REST-rajapinnan kuvaus UML-muodossa \(L&#xE4;hde: https://firstinfinity.wordpress.com/modeling\_rest\_web\_services/\)](.gitbook/assets/image%20%2812%29.png)

## Node.js ja REST APIt

Node.js sopii erinomaisesti rajapintojen toteuttamiseen palvelimella. Se on paitsi nopea ja tehokas tekemisissään, mutta mahdollisuus luoda helposti reittejä sekä kommunikoida ja välittää JSON-dataa tietokannalle tekevät kehittämisestä melko helppoa.

Aiemmin materiaalissa on jo esitelty oikeastaan kaikki ne toiminnallisuudet mitä tarvitse REST API:n rakentamiseen. Katsotaan seuraavaksi vielä kootusti miten yksinkertainen rajapinta toteutetaan.

## Luotavan rajapinnan hahmottelua

lorem

## Reittien luominen

## Tietokantaoperaatiot

## Pyyntöön vastaaminen



