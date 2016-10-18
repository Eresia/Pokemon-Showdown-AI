module ai.chooser.classic.random_chooser.ou_random_chooser;

import std.random;
import std.conv;

import data.data_storage;
import data.pokemon.team;
import data.pokemon.pokemon_condition;

import ai.chooser.classic.classic_chooser;

class OURandomChooser : ClassicChooser{

	public:

		this(){
			super();
		}

		override int lead(DataStorage data){
			return uniform(0, Team.NB_MAX_POKEMON)+1;
		}

		override string fight(DataStorage data){
			int move;

			do{
				move = uniform(0, PokemonCondition.NB_MAX_ATTACK)+1;
			}while(data.IsAttackDisable(move));
			return "move " ~ to!string(move);
		}

		override int forceSwitch(DataStorage data){
			int choice = -1;
			do{
				choice = uniform(0, Team.NB_MAX_POKEMON)+1;
			}while(data.getTeam().getPokemon(choice).isDead());
			return choice;
		}
}
