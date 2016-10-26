const fs = require('fs');

if(process.argv.length < 3){
	console.log("Need file name on argument");
	return;
}

var file = process.argv[2];
var newFile = file + "_conv";

console.log("Parsing file " + file + " into " + newFile);

fs.readFile(file, function(err, buffer) {
	if (err){
		console.log("Can't open file " + file);
		return;
	}
	var data = buffer.toString("ascii");
	var finalData = data.replace(/(['"])?([a-z0-9A-Z_]+)(['"])?:/g, '"$2": ');

	var fd = fs.openSync(newFile, "w+");
	fs.writeFileSync(fd,finalData, "utf8");
});

//var s= "{muh: 2,mah:3,moh:4}";
