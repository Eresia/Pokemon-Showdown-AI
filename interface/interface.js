var http = require('http');
var sockjs = require('sockjs');

var net = require('net');


var echo = sockjs.createServer();
var server = http.createServer();
var client = new net.Socket();
var showdownConnexion;


echo.on('connection', function(conn) {
    conn.on('data', function(data) {
        console.log("Received from Showdown : " + data);
		client.write(data);
    });
    conn.on('close', function() {
		console.log("Connexion from Showdown closed");
	});
	showdownConnexion = conn;
	console.log("Showdown connected");
});

echo.installHandlers(server, {prefix:'/echo'});
server.listen(8686, '0.0.0.0');



client.connect(8787, '127.0.0.1', function() {
	console.log("IA connected");
});
client.on('data', function(data) {
	console.log("Received from IA : " + data);
	showdownConnexion.write(data);
});

client.on('close', function() {
	console.log("Connexion from IA closed");
});
