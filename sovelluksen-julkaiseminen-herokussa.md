# Sovelluksen julkaiseminen Herokussa

Heroku on yksi tunnetuimmista omien sovellusten julkaisemiseen tarkoitetuista verkkopalveluista. Heroku on mahdollista [linkittää GitHubin koodirepositoryyn](https://youtu.be/55wxYOyml5Q), jolloin palvelu ottaa käyttöön aina viimeisimmän version koodista ja julkaisee sen automaattisesti.

Herokua käytettäessä Node.js -koodissa on huomioitava pari juttua.:

1. Kiinteän porttinumeron sijaan ohjelmassa on viitatta pilvipalvelimen määrittelemään PORT-muuttujaan:

```javascript
// index.js -tiedosto

const PORT = process.env.PORT || 5000;
var http = require("http");

//create a server object:
http
  .createServer(function(request, response) {
    response.writeHead(200, { "Content-Type": "text/plain" });
    response.write("Hello World!\n"); //write a response to the client
    response.end("This is the end"); //end the response
  })
  .listen(PORT); //the server object listens on port 
```

2. Koodin mukana tulee olla package.json -tiedosto, joka kertoo mm. käynnistettävän tiedoston nimen sekä moduulit, joita ohjelmaa varten tulee asentaa palvelimelle. Alla kuvitteellisen sovelluksen package.json-tiedosto.

```javascript
{
  "name": "nasademo",
  "version": "1.0.0",
  "description": "Demosovellus NASA APIin",
  "engines": {
    "node": "14.x"
  },
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "start": "node index.js"
  },
  "keywords": [
    "NASA",
    "API",
    "request"
  ],
  "author": "Mika",
  "license": "ISC",
  "dependencies": {
    "axios": "^0.21.1",
    "request": "^2.88.2"
  }
}
```



Herokun käyttö onnistuu myös komentorivin kautta ja lienee kaikkein kätevintä kun siihen tottuu. Prosessi on kuvattu hyvin täällä:   
 [https://www.geeksforgeeks.org/how-to-deploy-react-app-to-heroku/](https://www.geeksforgeeks.org/how-to-deploy-react-app-to-heroku/)

