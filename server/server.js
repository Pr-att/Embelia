const bodyParser = require("body-parser");
const express = require("express");
const PORT = process.env.PORT | 5001;
const app = express();
var mongoose = require('mongoose');


// Connect to MongoDB
mongoose.connect('mongodb+srv://pratyush-embelia:eC9cRHwus5Rr6iUb@embeliacluster.evgkcdj.mongodb.net/?retryWrites=true&w=majority', { useNewUrlParser: true });

app.use(bodyParser.json());

app.use(function(err, req, res, next) {
    res.status(422).send({error: err.message});
});

app.listen(PORT, function() {
    console.log(`Connected at ${PORT}`);
});