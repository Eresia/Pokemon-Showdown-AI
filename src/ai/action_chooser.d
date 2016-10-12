module ai.action_chooser;

import std.conv;

import ai.ai_action;

import data.data_storage;

abstract class ActionChooser {

	protected :
		DataStorage data;

		abstract string[] beginBattle();

		abstract string[] fight();

		abstract string[] forceSwitch();

		string[] makeSwitch(int newPokemon){
			string[] msg = new string[1];
			data.getTeam().switchPokemon(newPokemon);
			msg[0] = "/choose switch " ~ to!string(newPokemon) ~ "|" ~ to!string(data.getTurn());
			return msg;
		}

	public:
		this(DataStorage data){
			this.data = data;
		}

		abstract string[] makeAction(AIAction action);
}
