module ai.chooser.classic.better_chooser.ou_best_attack_chooser;

import std.random;
import std.conv;

import data.data_storage;
import data.pokemon.team;
import data.pokemon.pokemon_condition;

import ai.chooser.classic.classic_chooser;

class OUBestAttackChooser : ClassicChooser{

	public:

		this(){
			super();
		}

		override int lead(DataStorage data){
			return uniform(0, Team.NB_MAX_POKEMON)+1;
		}

		override string fight(DataStorage data){
			int move;
			string mega = "";

			do{
				move = uniform(0, PokemonCondition.NB_MAX_ATTACK)+1;
			}while(data.getActivePokemon().isAttackDisable(move));

			if(data.getActivePokemon().canMega()){
				mega = " mega";
			}
			return "move " ~ to!string(move) ~ mega;
		}

		override int forceSwitch(DataStorage data){
			int choice = -1;
			do{
				choice = uniform(0, Team.NB_MAX_POKEMON)+1;
			}while(data.getTeam().getPokemon(choice).isDead() || (data.getActivePokemon() == data.getTeam().getPokemon(choice)));
			return choice;
		}
}
