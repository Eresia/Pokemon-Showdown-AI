module data.pokemon.team;

import std.stdio;

import data.pokemon.pokemon_condition;

class Team {

	private:
		PokemonCondition[] pokemons;

	public:

		static final int NB_MAX_POKEMON = 6;

		this(){

		}

		void addPokemon(PokemonCondition p){
			if(pokemons.length < NB_MAX_POKEMON){
				pokemons ~= p;
			}
		}

		PokemonCondition getPokemon(int pokemon){
			return pokemons[pokemon-1];
		}

		bool teamIsDead(){
			bool result = true;

			for(int i = 0; i < NB_MAX_POKEMON; i++){
				result = (result && pokemons[i].isDead);
			}

			return result;
		}

		void switchPokemon(int pokemon){
			PokemonCondition temp = pokemons[0];
			pokemons[0] = pokemons[pokemon-1];
			pokemons[pokemon-1] = temp;
		}

		void cleanTeam(){
			pokemons = [];
		}

		ulong teamLength(){
			return pokemons.length;
		}
}
