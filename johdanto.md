# Johdanto web-kehitykseen

## Orientaatio

Web-sovellusten kehittäminen voidaan jakaa kahteen osa-aluuseen; ns.  front-end ja back-end kehittämiseen. Näistä ensimmäisellä tarkoitetaan kaikkea sitä, mikä näkyy tai suoritetaan käyttäjän selaimessa eri päätelaitteilla. Back-endillä puolestaan  tarkoitetaan palvelinympäristöä sekä niitä sovelluksia tai palveluita, jotka tuottavat sovelluksen vaatiman toimintalogiikan tai datan. Aiemmin samasta jaosta käytettiin nimeä  asiakas-palvelin -malli \(client-server\). Nämä kaksi maailmaa kommunikoivat Internetin välityksellä; selain lähettää esim. sivupyyntöjä tai lomakkeen tietoja back-endille. Palvelimella ajettu sovellus puolestaan vastaa esim. lähettämällä pyydetyn sivun sisältöineen tai prosessoimalla sille lähetetyn lomakedatan.

## Front-end ja Back-end

![Web-kehityksen putki; front- ja back-end kehitys.](.gitbook/assets/image%20%289%29.png)

Front-endin näkyvin osuus on selaimen esittämä käyttöliittymä verkkosivulle tai -sovellukselle, jonka tuottamiseen käytetään HTML-sivunkuvauskieltä ja CSS -tyylejä. Toiminnallisuus ja interaktiot käyttäjän kanssa toteutetaan selaimen suorittamalla JavaScript-ohjelmointikielellä. 

Back-endissä ajetaan tyypillisesti verkkosovelluksen logiikkaa sekä hallitaan siihen liittyviä tiedostoja. Tarvittaessa back-end suorittaa myös tietokantahakuja tai tallentaa selaimen sille välittämää uutta tietoa tietokantaan.

![Front- ja back-endin roolit verkkosovelluksessa.](.gitbook/assets/image%20%2813%29.png)

## Teknologiapinot

Web-kehittäjille on tarjolla iso kirjo erilaisia kirjastoja ja teknologioita koodaamisen tueksi. Yleisesti ottaen kulloinkin käyttöön valituista kirjastoista, kielistä ja sovelluksista puhutaan "teknologiapinoina" \(eng. "stack"\). Pinoon valitut komponentit määrittävät mitä ohjelmointikieliä ja palvelinohjelmistoja käytetään sekä minkälaisia tietokantaratkaisuja sovellus hyödyntää. Kaksi teknologiapinoa ovat tällä hetkellä vakiintuneet web-kehittäjien kehitysympäristöiksi: ns. LAMP- ja MEAN- pinot. 

LAMP on ollut standardiympäristö kehittäjille viimeiset 20 vuotta. Se  tulee sanoista Linux, Apache, MySQL ja PHP. Tällä konfiguraatiolla kehitetään ja suoritetaan isoa osaa verkkopalveluista ja blogialustoista tänäkin päivänä. Siinä web-palvelimen roolia hoitaa avoimen lähdekoodin Apache web -palvelin, ohjelmointikielenä toimii PHP ja tietokanta-alustana avoimen lähdekoodin MySQL \(nykyään MariaDB\).

MEAN edustaa uuden sukupolven web-teknologioita ja tulee sanoista MondoDB, Express.js, Angular ja Node. Siinä koko palvelimen virkaa hoitaa Node.js ympäristö, ohjelmointikielenä käytetään JavaScriptiä jota sekä Node että Express-sovelluskehys puhuvat. Tietokantaratkaisuna käytetään MongoDB:tä ja käyttöliittymän rakentamisessa hyödynnetään Angular-sovelluskehystä.

![LAMP- ja MEAN-teknologiapinot](.gitbook/assets/image%20%2821%29.png)

Huomattavaa on, että pinot ovat vain hyviin käytäntöihin ja kokemuksiin perustuvia määritelmiä käytetyistä ohjelmointi-ympäristöistä. Näinollen kukin kehittäjä voi koota oman "pinoonsa" tai vaihtaa komponentteja jo olemassaoleviin. Esim. MEAN stack -kehittäjät käyttävät usein käyttöliittymän rakentamiseen jotain muuta kuin Angularia, esim. Reactia. Tällöin puhutaan usein MERN-pinosta tai jopa ME\*N -pinosta. 

## Sovelluskehyksistä vielä...

Miksi ja mihin valmiita sovelluskehyksiä siis käytetään? Sovelluskehykset \(framework\) mahdollistavat koodin rakentamisen valmiiden rakenteiden ja toiminnallisuuksien ympärille siten, että kehittäminen on helpompaa ja nopeampaa. Kirjastot puolestaan tarjoavat valmiita funktioita tavanomaisimpiin operaatioihin - "pyörää ei ns. tarvitse keksiä uudestaan". 

Tunnetuimpia JavaScript sovelluskehyksiä tai kirjastoja ovat mm. Angular, React.js, Vue.js sekä jQuery. Merkittävimpiä HTML/CSS -kirjastoja/sovelluskehyksiä ovat mm. Bootstrap ja Foundation sekä Pure.css, SASS ja LESS.



