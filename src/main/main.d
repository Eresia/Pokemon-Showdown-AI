module main.main;

import std.stdio;
import std.string;
import std.algorithm;
import std.conv;
import std.json;
import std.file;

import game_controller.game_loop;

int main(string[] args){

	//GameLoop game = new GameLoop(8787);
	//game.start();

	char[] data = cast(char[]) read("usefool/pokedex.json");

	JSONValue parsed = parseJSON(data);

	return 0;
}
