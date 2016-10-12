module data.pokemon.pokemon_condition;

class PokemonCondition {

	private:
		string id;
		string details;
		int maxHP;
		int actualHP;
		int number;


	public:
		this(string id, string details, int maxHP, int number = -1){
			this.id = id;
			this.details = details;
			this.maxHP = maxHP;
			this.actualHP = maxHP;
			this.number = number;
		}

		void decreaseHP(int lostHP){
			this.actualHP -= lostHP;
			if(this.actualHP < 0){
				this.actualHP = 0;
			}
		}

		void setHP(int hp){
			this.actualHP = hp;
		}

		bool isDead(){
			return (actualHP == 0);
		}
}
