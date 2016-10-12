module ai.ai_controller_ou;

import std.stdio;
import std.conv;

import ai.classic_action_chooser;
import ai.ai_action;

import data.data_storage;
import data.pokemon.team;

class AIControllerOU : ClassicActionChooser {

	protected:

		override string[] beginBattle(){

			data.incrementTurnShift();

			string fileName = "exemple_team.txt";
			File f = File(fileName, "r");
			string[] msg = new string[2];

			msg[0] = "/utm " ~ f.readln();
			msg[1] = "/challenge eresias, ou";
			return msg;
		}

		override string[] lead(){
			string[] msg = new string[1];
			int choice = 1;
			makeSwitch(choice);
			msg[0] = "/team " ~ to!string(choice);

			for(int i = 2; i <= 6; i++){
				if(i != choice){
					msg[0] ~= to!string(i);
				}
				else{
					msg[0] ~= "1";
				}
			}
			msg[0] ~= "|1";
			return msg;
		}

		override string[] fight(){
			string[] msg = new string[1];
			msg[0] = "/choose move 1|" ~ to!string(data.getTurn());
			return msg;
		}

		override string[] forceSwitch(){
			int choicePokemon = 1;
			for(int i = 2; i <= Team.NB_MAX_POKEMON; i++){
				if(!data.getTeam().getPokemon(i).isDead()){
					choicePokemon = i;
					break;
				}
			}

			return makeSwitch(choicePokemon);
		}

	public:
		this(DataStorage data){
			super(data);
		}

}
