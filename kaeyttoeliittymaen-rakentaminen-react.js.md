# Käyttöliittymän rakentaminen Node-sovellukselle: React.js

## Orientaatio

Nodella on tässä materiaalissa toteutettu back-end sovelluksia, jotka vastaanottavat selaimelta palvelupyyntöjä ja lomakkeilta lähetettyä dataa, suorittavat pyyntöihin liittyvät toimenpiteet kuten tiedoston käsittely tai tietokantakutsut ja lopuksi palauttavat selaimelle jonkinlaisen vastauksen. 

Sovellusten front-endiin eli selaimen esittämään käyttöliittymäkerrokseen ei ole vielä otettu kantaa, muuten valmiiden tyylikirjastojen hyödyntämisen näkökulmasta \(Bootstrap, Pure.css\). 

Tässä osassa tehdään tiivis katsaus suosittuun React-kirjastoon, jota voidaan hyödyntää käyttöliittymien rakentamisessa web-sovelluksiin.

## Yleistä

Front-end ohjelmoinnissa on tällä hetkellä kaksi suurta frameworkkia \(sovelluskehystä\): [Angular ](https://angularjs.org/)ja [ReactJS](https://facebook.github.io/react/). Lisäksi altavastaajana markkinoille on ilmestynyt kevyempi ja monen mielestä edellisiä helpommin omaksuttava ja pienempikokoinen Vue. 

AngularJS on Googlen vuonna 2010 julkaisema tuote, joka koki uudelleensyntymän vuonna 2016. Tämän jälkeen siitä on käytetty nimeä Angular V2 \(ilman JS-päätettä\). React on puolestaan Facebookin alunperin vuonna 2013 kehittämä framework, joka saavutti nopeasti suuren suosion julkaisunsa jälkeen. 

Angular 2 on käytännössä kokonaan uudelleenkirjoitettu toteutus Googlen tuotteesta, minkä myötä myös ohjelmien logiikka on erilainen. Näinollen vanhat AngularJS-sovelluksetkaan eivät ole enää yhteensopivia Angular 2:n kanssa. Tämä aiheutti ymmärrettävästi kuohuntaa web-kehittäjien keskuudessa ja se lienee myös verottanut frameworkin käyttäjiä. Angularin alkuperäinen versio on edelleen laajasti käytössä.

## Vertailua

Vertailu sovelluskehysten välillä on hieman hankalaa, koska ne on suunniteltu erilaisiksi. Angular on täydellinen MVC-mallin mukainen \(Model-View-Controller\) sovelluskehys, mikä vaatii kehitettävältä sovellukselta tietynlaista rakennetta ja koodaustapaa. Tämä nostaa Angularin osaamiskurvia jonkin verran ja tekee siitä vaikeammin lähestyttävän. 

Sen sijaan React on oikeastaan enemmänkin JavaScript-kirjasto, joka tarjoaa mahdollisuuden käyttöliittymäkomponenttien rakentamiseen JavaScriptillä. React ei tarjoa kaikkea sovellusten vaatimaa toiminnallisuutta itse, eli esim. reittien luomiseen tai tilanhallintaan joudutaan hyödyntämään lisäkirjastoja. 

Reactiin kehitettyjen lisäpalikoiden, kuten [React Nativen](https://reactnative.dev/) avulla, on sillä myös mahdollista tehdä mobiilisovelluksia jotka kääntyvät natiivikoodiksi Androidille ja iOS:lle. Latausmäärien ja työpaikkailmoitusten perusteella React tuntuu olevan tällä hetkellä kaikkein suosituin ja kysytyin teknologia.

Verkosta löytyy erilaisia [vertailuja ](https://www.themexpert.com/blog/angular-vs-react-vs-vue)näiden kolmen ominaisuuksista. 

![Kuva: Frameworkkien vertailua \(https://www.themexpert.com/blog/angular-vs-react-vs-vue\).](.gitbook/assets/image%20%2811%29.png)

## Ensimmäinen ohjelma 

Reactin kokeilu on tehty helpoksi. Saat ladattua Reactin kirjastot ja esimerkkisovelluksen yhdellä komennolla käyttöösi. Tämä prosessi on kuvattu hyvin Reactin omassa dokumentaatiossa [täällä](https://reactjs.org/docs/create-a-new-react-app.html#create-react-app). Ideana on käyttää npx-komentoa, joka lataa \(kuten npm\) tarvittavat koodit koneellesi ja suorittaa asennustoimenpiteet. 

Tämän jälkeen voit käynnistää Node-sovelluksen \(npm start\), joka käynnistää web-palvelin ja tarjoilee esimerkkisovelluksen selaimessa osoitteessa http://localhost:3000.

```bash
npx create-react-app my-app
cd my-app
npm start
```

Sovellus aukeaa selaimeen ja näyttää esimerkkisovelluksen tuottaman HTML-sivun \(alla\). Vieressä myös hakemistolistaus React-sovelluksen sisältämistä tiedostoista.

![](.gitbook/assets/image%20%2825%29.png)

Sovellus asuu hakemistossa **myApp**, joka annettiin create-react-app -komennolle parametrina. Sen sisällä on monenlaista tavaraa, josta keskeisin on kuitenkin sovelluksen JavaScript-koodin sisältämä **src**.

Avataan src-kansiosta index.js -tiedosto ja korvataan koko sen sisältö omalla sovelluksella. 

```jsx
import React from "react";
import ReactDOM from "react-dom";

const App = () => (
  <div>
    <h1>Ensimmäinen React-sovellukseni!</h1>
  </div>
);

ReactDOM.render(<App />, document.getElementById("root"));

```

Tallenna tiedosto tämän jälkeen \(Node-palvelin käynnistyy uudestaan automaattisesti= ja lataa selaimella sivu uudestaan. Muutosten tulisi näkyä selaimessa.  

![Kuva: Muokattu React-sovellus.](.gitbook/assets/image%20%2828%29.png)

## Koodin läpikäynti

Ohjelmakoodissa tuodaan ensin import-lauseilla sovelluksen käyttöön Reactin omia kirjastoja. Tämän jälkeen riveillä 4-8 määritellään App-niminen "komponentti" käyttäen Reactin omaa JSX-notaatiota. Tässä luodaan siis HTML-koodia JavaScriptin avulla, ja siitä koko Reactissa on oikeastaan kysymys. 

Lopuksi rivillä 10 pyydetään Reactia renderöimään eli piirtämään äsken luomamme komponentti "App" HTML-sivulta löytyvään elementtiin, jonka id=root \[document.getElementById\("root"\)\]. 

Sivupohja johon sovellus komponentteja sijoittelee löytyy public-hakemistosta ja on nimeltään index.html. Se on käytännössä tyhjä HTML-sivu, johon on lisätty muutamia rakenteellisia elementtejä. 

Sivupohjan &lt;body&gt; -tägin sisältö on näkyvissä ao. kuvassa. Huomaa &lt;div&gt; -elementti ja sen id "root". Tämän lohkon sisälle React siis sijoittaa edellä luodun komponentin.

![](.gitbook/assets/image.png)

## **Komponenttien kierrätystä**

Reactissa komponentteja voidaan luoda lisää ja uudelleenkäyttää. Luodaan seuraavaksi toinen komponentti &lt;Hello /&gt; jota kutsutaan aiemmin luodusta &lt;App /&gt; komponentista.

```jsx
import React from "react";
import ReactDOM from "react-dom";

const App = () => (
  <div>
    <h1>Ensimmäinen React-sovellukseni!</h1>
    <Hello />
    <Hello />
    <Hello />
  </div>
);

const Hello = () => (
  <div>
    <p>Hoi Maailma!</p>
  </div>
);

ReactDOM.render(<App />, document.getElementById("root"));
```

Lisäämällä tuulimääreet index.html -tiedostoon \( ennen &lt;body&gt; tägiä \) saadaan sivulle vähän ilmettä.

```jsx
<style>
    div p {
      border: 1px solid blue;
      border-radius: 10px;
      padding: 10px;
    }
  </style>
```

![Kuva: React-sovellus tyyleill&#xE4;.](.gitbook/assets/image%20%2844%29.png)

## **Reactin sielunelämää**

Vaikka esimerkkiohjelma käynnistää Reactin Node-sovelluksen pyörittämässä web-palvelimessa, voidaan Reactia hyödyntävä web-sivu tai -sovellus tarjoilla minkä tahansa web-palvelimen kautta; sehän koostuu tutuista HTML/CSS/JavaScript-tiedostoista, joita selain osaa sellaisenaan suorittaa. 

Mainittakoon myös, että React-sovelluksen "paketointi" vaatii kohtalaisen määrän työkaluja, joiden läpi kirjoitettu sovelus ajetaan \(edellä ajetussa esimerkkiohjelmassa työkalut ovat valmiiksi konfiguroitu\) Näitä ovat mm. [Babel](https://babeljs.io/) \(joka kääntää JavaScriptin uusimman version ES6:n mukaan kirjoitetun koodin selainten tukemaan JS:n muotoon\) sekä [Webpack](https://webpack.js.org/) \(joka paketoi lukuisat JavaScript-moduulit yhdeksi fyysiseksi tiedostoksi selainten ymmärtämään muotoon\) . Näitä ei tässä materiaalissa kuitenkaan sen enempää käsitellä.

## Tiedonvälitys komponenteille \(props\)

Komponentti joka tulostaa tervehdyksen on kätevä, mutta se olisi vielä monikäyttöisempi jos tervehdystä voisi tarpeen vaatiessa muuttaa. Tähän käytetään propseja, jotka toimivat ohjelmointikielissä tuttujen parametrien tavoin. Tehdään komponentti, joka saa kutsuvaiheessa parametreja 

Komponentin määrittelyssä JSX funktio saa parametrina props-olion. Komponentin luoma HTML-koodi puolestaan sijoittelee props-olion sisältämiä kenttiä \(color, greetging, author\) sopiviin paikkoihin.

```jsx
const CustomHello = (props) => {
  return (
    <div>
      <p className={props.color}>
        {props.greeting} (<strong> {props.author} </strong> )
      </p>
    </div>
  );
};
```

Komponentin käyttö tapahtuisi seuraavalla tavalla. Huomaa miten komponentin kutsussa määritellään attrribuutit, jotka välittävät tietoa komponenttiin:

```jsx
import React from "react";
import ReactDOM from "react-dom";

const App = () => (
  <div>
    <h1>Ensimmäinen React-sovellukseni!</h1>
    <Hello />
    <Hello />
    <CustomHello author="Mika" greeting="Tervepä terve." />
    <CustomHello
      author="Matti"
      greeting="Se on morjens!"
      color="green"
    />
  </div>
);
```

Ohjelman suoritus näyttää seuraavalta:

![Kuva: Ohjelman suoritus.](.gitbook/assets/image%20%2830%29.png)



