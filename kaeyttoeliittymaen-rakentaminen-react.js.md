# Käyttöliittymän rakentaminen Nodessa: React.js

## Orientaatio

Nodella on tässä materiaalissa toteutettu back-end sovelluksia, jotka vastaanottavat selaimelta palvelupyyntöjä ja lomakkeilta lähetettyä dataa, suorittavat pyyntöihin liittyvät toimenpiteet kuten tiedoston käsittely tai tietokantakutsut ja lopuksi palauttavat selaimelle jonkinlaisen vastauksen. Sovellusten front-endiin eli selaimen esittämään käyttöliittymäkerrokseen ei ole vielä otettu kantaa, muuten valmiiden tyylikirjastojen hyödyntämisen näkökulmasta \(Bootstrap, Pure.css\). Tässä osassa tehdään tiivis katsaus suosittuun React-kirjastoon, jota voidaan hyödyntää käyttöliittymien rakentamisessa web-sovelluksiin.

## Yleistä

Front-end ohjelmoinnissa on tällä hetkellä kaksi suurta frameworkkia \(sovelluskehystä\): [Angular ](https://angularjs.org/)ja [ReactJS](https://facebook.github.io/react/). Lisäksi altavastaajana markkinoille on ilmestynyt kevyempi ja monen mielestä edellisiä helpommin omaksuttava ja pienempikokoinen Vue. 

AngularJS on Googlen vuonna 2010 julkaisema tuote, joka koki uudelleensyntymän vuonna 2016. Tämän jälkeen siitä on käytetty nimeä Angular V2 \(ilman JS-päätettä\). React on puolestaan Facebookin alunperin vuonna 2013 kehittämä framework, joka saavutti nopeasti suuren suosion julkaisunsa jälkeen. 

Angular 2 on käytännössä kokonaan uudelleenkirjoitettu toteutus Googlen tuotteesta, minkä myötä myös ohjelmien logiikka on erilainen. Näinollen vanhat AngularJS-sovelluksetkaan eivät ole enää yhteensopivia Angular 2:n kanssa. Tämä aiheutti ymmärrettävästi kuohuntaa web-kehittäjien keskuudessa ja se lienee myös verottanut frameworkin käyttäjiä. Angularin alkuperäinen versio on edelleen laajasti käytössä.

## Vertailua

Vertailu sovelluskehysten välillä on hieman hankalaa, koska ne on suunniteltu erilaisiksi. Angular on täydellinen MVC-mallin mukainen \(Model-View-Controller\) sovelluskehys, mikä vaatii kehitettävältä sovellukselta tietynlaista rakennetta ja koodaustapaa. Tämä nostaa Angularin osaamiskurvia jonkin verran ja tekee siitä vaikeammin lähestyttävän. 

Sen sijaan React on oikeastaan enemmänkin JavaScript-kirjasto, joka tarjoaa mahdollisuuden käyttöliittymäkomponenttien rakentamiseen JavaScriptillä. React ei tarjoa kaikkea sovellusten vaatimaa toiminnallisuutta itse, eli esim. reittien luomiseen tai tilanhallintaan joudutaan hyödyntämään lisäkirjastoja. Reactiin kehitettyjen lisäpalikoiden, kuten [React Nativen](https://reactnative.dev/) avulla, on sillä myös mahdollista tehdä mobiilisovelluksia jotka kääntyvät natiivikoodiksi Androidille ja iOS:lle. Latausmäärien ja työmarkkinoiden perusteella React tuntuu olevan tällä hetkellä kaikkein suosituin ja kysytyin tuote.

Verkosta löytyy erilaisia [vertailuja ](https://www.themexpert.com/blog/angular-vs-react-vs-vue)näiden kolmen ominaisuuksista. 

![Kuva: Frameworkkien vertailua \(https://www.themexpert.com/blog/angular-vs-react-vs-vue\).](.gitbook/assets/image%20%288%29.png)

## Ensimmäinen kokeilu

Reactin kokeilu on tehty helpoksi. Saat ladattua Reactin kirjastot ja esimerkkisovelluksen yhdellä komennolla käyttöösi. Tämä prosessi on kuvattu hyvin Reactin omassa dokumentaatiossa [täällä](https://reactjs.org/docs/create-a-new-react-app.html#create-react-app). Ideana on käyttää npx-komentoa, joka lataa \(kuten npm\) tarvittavat koodit koneellesi ja suorittaa asennustoimenpiteet. 

Tämän jälkeen voit käynnistää Node-sovelluksen \(npm start\), joka käynnistää web-palvelin ja tarjoilee esimerkkisovelluksen selaimessa.

```bash
npx create-react-app my-app
cd my-app
npm start
```

kuva

### Reactin sielunelämää

Vaikka esimerkkiohjelma käynnistää Reactin Node-sovelluksen pyörittämässä web-palvelimessa, voidaan Reactia hyödyntävä web-sivu tai -sovellus tarjoilla minkä tahansa web-palvelimen kautta; sehän koostuu tutuista HTML/CSS/JavaScript-tiedostoista, joita selain osaa sellaisenaan suorittaa. 

Mainittakoon myös, että React-sovelluksen "paketointi" vaatii kohtalaisen määrän työkaluja, joiden läpi kirjoitettu sovelus ajetaan. Näitä ovat mm. Babel ja Webpack. Näistä ei tässä materiaalissa kuitenkaan sen enempää.

