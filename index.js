const express = require("express");
const app = express();
const port = 3000;
let countError = 0;

function getRandomInt(max) {
    return Math.floor(Math.random() * Math.floor(max));
}

function getTest(req, res) {
    if (getRandomInt(2) === 0) {
        res.send("Hello World!");
    } else {
        res.status(500).send("error");
        console.log('error', countError++);
    }
}

app.get("/", (req, res) => res.send("Hello World!"));

app.get("/test", getTest);

app.listen(port, () => console.log(`Example app listening on port port!`));

console.log("Server running at http://127.0.0.1:3000/");