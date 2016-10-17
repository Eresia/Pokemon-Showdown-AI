module ai.ai_controller_ou;

import std.stdio;
import std.conv;
import std.random;

import ai.classic_action_chooser;
import ai.ai_action;
import ai.chooser.ou.ou_chooser;

import data.data_storage;
import data.pokemon.team;

class AIControllerOU : ClassicActionChooser {

	private:

	protected:

		override string[] beginBattle(){

			data.incrementTurnShift();

			string fileName = "exemple_team.txt";
			File f = File(fileName, "r");
			string[] msg = new string[2];
			string pseudo = "eresias";

			msg[0] = "/utm " ~ f.readln();
			msg[1] = "/challenge " ~ pseudo ~ ", ou";
			return msg;
		}

		override string[] lead(){
			string[] msg = new string[1];

			OUChooser leadChooser = cast(OUChooser) chooser;

			int choice = leadChooser.lead(data);

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

			string move = chooser.fight(data);

			msg[0] = "/choose " ~ move ~ "|" ~ to!string(data.getTurn());
			return msg;
		}

		override string[] forceSwitch(){

			int choicePokemon = chooser.forceSwitch(data);

			return makeSwitch(choicePokemon);
		}

	public:
		this(DataStorage data, OUChooser chooser){
			super(data, chooser);
		}

}
