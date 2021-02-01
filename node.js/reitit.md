# Reitit

Reittien avulla Nodella luotuun web-palvelimeen saadaan rakennettua erilaisia toiminnallisia lohkoja. Ideana on tutkia käyttäjän lähettämästä HTTP-pyynnöstä mitä polkua palvelimelta pyydetään. Esim. jos käyttäjän selain pyytää palvelimen juurihakemistoa \("/"\) voidaan suorittaa eri koodilohko kuin jos pyyntönä on esim. polku "/helloworld".

Alla esimerkkikoodi, jossa käyttäjälle tarjoillaan 3 erilaista reittiä. Huomaa, että reitit 2 ja 3 tarjoilevat käyttäjälle tiedoston sisällön staattisen tulosteen sijaan. 

Viimeinen reitti tulostaa JSON-muotoisen datasetin ruudulle. Jos tämä näyttää tutulta, niin olet ehkä operoinut erilaisten REST APIen kanssa joskus aiemmin. Tyypillisesti sekä REST API:t että useat NoSQL-tietokannat palauttavat selaimelle datan nimenomaan JSON-muodossa. Jotta JSON-saadan esitettyä merkkijonona ruudulla, käytetään JSON.stringify-funktiota.

```javascript
var http = require("http");
var fs = require("fs");

//create a server object:
http.createServer(function(request, response) {
     
    if (request.url === "/"){
        // Valitaan Content-type tarjoiltavan sisällön suhteen
        response.writeHead(200, { "Content-Type": "text/plain" });
        
        // Lähetetään tekstimuotoinen vastaus selaimelle
        response.write("Olet saapunut palvelimen juureen.");
        } 
    else if (request.url === "/helloworld"){  
        // Valitaan Content-type tarjoiltavan sisällön suhteen
        response.writeHead(200, { "Content-Type": "text/html" });
        
        // Luetaan HTML-tiedosto ja lähetetään se selaimelle
        var html = fs.readFileSync('frontpage.html');
        response.write(html);
        } 

    else if (request.url === "/json"){
        // Valitaan Content-type tarjoiltavan sisällön suhteen
        response.writeHead(200, { "Content-Type": "text/html" });
        
        // Luetaan JSON muotoinen tiedosto ja lähetetään se selaimelle
        var json = require('./data.json');      
        response.write(JSON.stringify(json));
        } 
        
        response.end(); //HTTP vastaus päättyy
  })
  .listen(8081); // palvelin kuuntelee porttia 8081

```

## 

