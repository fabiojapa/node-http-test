const express = require("express");
const app = express();
const port = 3000;
let countOk = 0;
let countError = 0;

function getRandomInt(max) {
    return Math.floor(Math.random() * Math.floor(max));
}

function getTest(req, res) {
    if (getRandomInt(5) === 0) {
        res.send("CANARY-Saka World 4.0x!");
        console.log('ok', countOk++);
    } else {
        res.status(500).send("error");
        console.log('error', countError++);
    }
}

app.get("/", (req, res) => {
    res.send("CANARY-SAKA - Ola Mundo v4");
});

app.get("/test", getTest);

app.get("/ok", (req, res) => {
    res.send("CANARY-Saka World 4.0x!");
    console.log('ok', countOk++);
});

app.listen(port, () => console.log(`Example app listening on port port!`));

console.log("Server running at http://127.0.0.1:3000/");