var express = require('express');
var fs = require('fs');
var app = express();

app.get('/', function (req, res) {
   res.sendFile(__dirname + '/public/index.html');
});

app.get('/details', function(req, res) {

 var data = require('./exampledata2.json');

 var results = '<table border="1"> ';

 for (var i = 0; i < data.length; i++) {
  results +=
   '<tr>' +
   '<td>' + data[i].Name + '</td>' +
   '<td>' + data[i].Email + '</td>' +
   '</tr>';
 }

 res.send(results);
});

app.listen(8080, function() {
 console.log('Example app listening on port 8080!');
});
