module ai.ai_controller;

import std.conv;

import socket.data_traitment;

import ai.ai_action;

class AIController {

	private:
		DataTraitment data;

		string beginBattle(){
			string msg = "/challenge eresias, randombattle";
			return msg;
		}

		string fight(){
			string msg = "/choose move 1|" ~ to!string(data.getTurn());
			return msg;
		}

		string forceSwitch(){
			string msg = null;
			return msg;
		}

	public:
		this(DataTraitment data){
			this.data = data;
		}

		string makeAction(AIAction action){
			string result;
			switch(action){
				BEGIN:
					result = beginBattle();
					break;
				FIGHT:
					result = fight();
					break;
				FORCE_SWITCH:
					result = forceSwitch();
					break;
				default:
					result = null;
			}

			return result;
		}

}
