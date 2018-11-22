function getResult(callback) {
  MongoClient.connect(
    url,
    function(err, db) {
      if (err) {
        console.log("Unable to connect to the mongoDB server. Error:", err);
      } else {
        console.log("Connection established to", url);

        // Get the documents collection
        var collection = db.collection("car");

        // Query the collection
        collection.find(),
          function(err, result) {
            if (err) {
              console.log(err);
            } else if (result.length) {
              console.log("Found:", result);
            } else {
              console.log('No document(s) found with defined "find" criteria!');
            }
            //Close connection
            db.close();
            callback(err, result);
          };
      }
    }
  );
}
// index page
app.get("/", function(req, res) {
  var result = getResult(function(err, result) {
    //handle err, then you can render your view
    res.render("pages/index", { collection: result });
  });
});
