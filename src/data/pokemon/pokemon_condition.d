module data.pokemon.pokemon_condition;

import std.stdio;

class PokemonCondition {

	private:
		string id;
		string details;
		int maxHP;
		int actualHP;
		int number;


	public:

		static const int NB_MAX_ATTACK = 4;

		this(string id, string details, int maxHP, int actualHP, int number = -1){
			this.id = id;
			this.details = details;
			this.maxHP = maxHP;
			this.actualHP = actualHP;
			this.number = number;
		}

		void decreaseHP(int lostHP){
			this.actualHP -= lostHP;
			if(this.actualHP < 0){
				this.actualHP = 0;
			}
		}

		void setHP(int hp){
			writeln("NEW HP for ", id, " is : ", hp);
			this.actualHP = hp;
		}

		bool isDead(){
			return (actualHP == 0);
		}
}
