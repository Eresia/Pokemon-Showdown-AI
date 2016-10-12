module ai.ai_controller_rand;

import std.stdio;
import std.conv;

import ai.random_action_chooser;
import ai.ai_action;

import data.data_storage;

class AIControllerRand : RandomActionChooser {

	protected:

		override string[] beginBattle(){

			string[] msg = new string[1];
			msg[0] = "/challenge eresias, randombattle";
			return msg;
		}

		override string[] fight(){
			string[] msg = new string[1];
			msg[0] = "/choose move 1|" ~ to!string(data.getTurn());
			return msg;
		}

		override string[] forceSwitch(){
			string[] msg;
			msg = null;
			return msg;
		}

	public:
		this(DataStorage data){
			super(data);
		}

}
