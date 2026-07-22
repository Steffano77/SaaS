const http = require("http");
const { execSync } = require("child_process");
const crypto = require("crypto");

const SECRET = "panificapro_deploy_2026";
const PORT = 9000;

const server = http.createServer((req, res) => {
  if (req.method === "POST" && req.url === "/deploy") {
    let body = "";
    req.on("data", chunk => body += chunk);
    req.on("end", () => {
      const sig = req.headers["x-hub-signature-256"] || "";
      const hmac = "sha256=" + crypto.createHmac("sha256", SECRET).update(body).digest("hex");
      if (sig !== hmac) {
        res.writeHead(403);
        res.end("Forbidden");
        return;
      }
      try {
        const out = execSync("cd /var/www/site-panificapro && git pull && cp -rT . /var/www/site/ 2>&1", {timeout: 30000});
        console.log("[deploy]", new Date().toISOString(), out.toString());
        res.writeHead(200);
        res.end("OK");
      } catch(e) {
        console.error(e.message);
        res.writeHead(500);
        res.end("Error");
      }
    });
  } else {
    res.writeHead(404);
    res.end();
  }
});

server.listen(PORT, () => console.log("Webhook ouvindo na porta " + PORT));
