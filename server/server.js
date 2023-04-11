const bodyParser = require("body-parser");
const express = require("express");
const PORT = process.env.PORT | 5001;
const app = express();

app.use(bodyParser.json());
app.use('/', require('./routes/api'));

app.use(function(err, req, res, next) {
    res.status(422).send({error: err.message});
});

app.listen(PORT, function() {
    console.log(`Connected at ${PORT}`);
});