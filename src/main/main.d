module main.main;

import std.stdio;
import std.string;
import std.conv;

import game_controller.game_loop;

int main(string[] args){

	GameLoop game = new GameLoop(8787);
	game.start();

	return 0;
}
