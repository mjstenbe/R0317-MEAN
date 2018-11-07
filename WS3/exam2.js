var express = require('express');
var fs = require('fs');
var app = express();
var bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({
 extended: true
})); 

app.post('/adduser', function(req, res) {

 var data = require('./exampledata2.json');

 data.push({
  "Name": req.body.name,
  "Company": req.body.company,
  "Email": req.body.email,
  "Date": new Date()
 });

 var jsonStr = JSON.stringify(data);

 fs.writeFile('exampledata2.json', jsonStr, (err) => {
  if (err) throw err;
 });
 res.send("Done!");
});
