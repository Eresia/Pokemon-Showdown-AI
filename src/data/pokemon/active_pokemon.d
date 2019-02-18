module data.pokemon.active_pokemon;

import data.pokemon.pokemon_condition;

class ActivePokemon{

	private:
		bool[] disableAttacks;
		bool mega;
		bool trapped;

	public:
		this(){
			disableAttacks = new bool[PokemonCondition.NB_MAX_ATTACK];
			cleanInformation();
		}

		void cleanInformation(){
			for(int i = 0; i < disableAttacks.length; i++){
				disableAttacks[i] = false;
			}

			mega = false;
			trapped = false;
		}

		bool isAttackDisable(int i){
			return disableAttacks[i-1];
		}

		bool canMega(){
			return mega;
		}

		bool isTrapped(){
			return trapped;
		}

		void setAttackDisable(int i, bool isDisable){
			this.disableAttacks[i] = isDisable;
		}

		void setCanMega(bool mega){
			this.mega = mega;
		}

		void setTrapped(bool trapped){
			this.trapped = trapped;
		}
}
