// curl -k https://localhost:3000/
const https = require('https');
const fs = require('fs');

const options = {
  key: fs.readFileSync('nsqa-ingress-tls.key'),
  cert: fs.readFileSync('nsqa-ingress-tls.crt')
};

https.createServer(options, (req, res) => {
  res.writeHead(200);
  res.end('CANARY HTTPS V2\n');
}).listen(3000);

console.log('Server running at https://127.0.0.1:3000/');