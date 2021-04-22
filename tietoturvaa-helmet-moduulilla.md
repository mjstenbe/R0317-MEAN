# Tietoturvaa Helmet-moduulilla

Express-pohjainen web-sovellus on altis monenlaisille verkkohyökkäyksille. Tätä varten on kehitetty Helmet-niminen moduuli. Sen käyttöönotto suojaa sovelluksen automaattisesti 11 ongelmalta.

Pakkauksen käyttöönotto on helppoa. Asennetaan moduuli ensin npm:llä:  

```text
npm i helmet
```

Sen jälkeen tuodaan se ja otetaan se käyttöön express-sovellukseen:

```javascript
const express = require("express");
const helmet = require("helmet");

const app = express();

app.use(helmet());
```

Tarkemmin moduulin toiminnasta voit lukea [täältä](https://www.npmjs.com/package/helmet).



