module ai.action_processing.action_processing;

import std.conv;

import ai.ai_action;
import ai.chooser.chooser;

import data.data_storage;

abstract class ActionProcessing {

	protected :
		DataStorage data;
		Chooser chooser;

		abstract string[] beginBattle();

		abstract string[] fight();

		abstract string[] forceSwitch();

		string[] makeSwitch(int newPokemon){
			string[] msg = new string[1];
			data.getTeam().switchPokemon(newPokemon);
			msg[0] = "/choose switch " ~ to!string(newPokemon) ~ "|" ~ to!string(data.getRqid());
			return msg;
		}

	public:
		this(DataStorage data, Chooser chooser){
			this.data = data;
			this.chooser = chooser;
		}

		abstract string[] makeAction(AIAction action);
}
