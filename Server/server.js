
const http = require("http")
const files = require("fs")
const url = require("url")

const PORT = 8752

var passcode;

var openHosts = {}


files.readFile("passcode.txt", "utf8", function(err, data) {
    passcode = data
    console.log("Passcode is "+passcode)
});

http.createServer((req, res) => {

    var headers = JSON.parse(JSON.stringify(req.headers))

    res.setHeader('Content-Type', 'application/json');

    if (headers.passcode == passcode) {

        if (headers.type == "add") {
            
            openHosts[headers.name] = headers.ip
            res.write("IP Added")
            res.end()

        }

        else if (headers.type == "remove") {

            if (headers.name in openHosts) {
                delete openHosts[headers.name]
                res.write("IP Removed")
                res.end()
            }

        }

        else if (headers.type == "get") {
            res.write(JSON.stringify(openHosts))
            res.end()
        }

    } else {
        res.end("Invalid Passcode")
    }


}).listen(PORT)

