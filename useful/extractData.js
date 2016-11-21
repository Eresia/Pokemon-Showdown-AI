var fs = require('fs');

var pokedex = require('./pokedex.js').BattlePokedex;
var moves = require('./moves.js').BattleMovedex;
var abilities = require('./abilities.js').BattleAbilities;
var items = require('./items.js').BattleItems;

var parsedPokedex = JSON.stringify(pokedex, null, 4);
var parsedMoves = JSON.stringify(moves, null, 4);
var parsedAbilities = JSON.stringify(abilities, null, 4);
var parsedItems = JSON.stringify(items, null, 4);

/*fs.writeFile("pokedex.json", parsedPokedex, function(err) {
    if(err) {
        return console.log(err);
    }
});*/

/*fs.writeFile("moves.json", parsedMoves, function(err) {
    if(err) {
        return console.log(err);
    }
});*/

/*fs.writeFile("abilities.json", parsedAbilities, function(err) {
    if(err) {
        return console.log(err);
    }
});*/

fs.writeFile("items.json", parsedItems, function(err) {
    if(err) {
        return console.log(err);
    }
})
