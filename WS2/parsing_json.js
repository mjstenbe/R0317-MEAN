// Simple demo on parsing JSON

var data = require("./quotes2.json");
 
// Parse the results

for (var i = 0; i < data.length; i++) {
  console.log(data[i].quote);
  console.log(data[i].author);
}
