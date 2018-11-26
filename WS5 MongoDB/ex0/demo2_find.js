const MongoClient = require("mongodb").MongoClient;

// Connection URL
const url = "mongodb://localhost:27017/";

// Database Name
const dbName = "moviedb";

// Use connect method to connect to the server

MongoClient.connect(
  url,
  { useNewUrlParser: true },
  function(err, client) {
    if (err) console.log("Tapahtui virhe!");

    const db = client.db(dbName);
    // Query can be copied from Compass
    var query = { year: { $gt: 2000 } };
    db.collection("movies")
      .find(query)
      .limit(5)
      .toArray(function(err, result) {
        if (err) throw err;
        console.log(result);
      });
    client.close();
  }
);
