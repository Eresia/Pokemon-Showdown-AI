module data.data_storage;

import data.pokemon.team;
import data.pokemon.pokemon_condition;

class DataStorage {

	private:

		int turnShift;

		bool connected;
		bool waitForSwitch;
		bool needRefreshTeam;
		string pseudo;
		string battleName;
		int idPlayer;
		int turn;

		Team team;

		bool[] disableAttacks;
		bool mega;

	public:
		this(){
			connected = false;
		 	pseudo = "Guest";
			team = new Team();
			disableAttacks = new bool[PokemonCondition.NB_MAX_ATTACK];
			cleanInformation();
		}

		void cleanInformation(){
			turn = 0;
			battleName = "Not defined";
			waitForSwitch = false;
			needRefreshTeam = true;
			idPlayer = -1;
			turnShift = 0;
			team.cleanTeam();

			for(int i = 0; i < disableAttacks.length; i++){
				disableAttacks[i] = false;
			}

			mega = false;
		}

		/*==========Getters===========*/
		bool isConnected(){
			return connected;
		}

		bool isWaitForSwitch(){
			return waitForSwitch;
		}

		bool isNeedRefreshTeam(){
			return needRefreshTeam;
		}

		string getPseudo(){
			return pseudo;
		}

		string getBattleName(){
			return battleName;
		}

		int getIdPlayer(){
			return idPlayer;
		}

		int getTurn(){
			return turn + turnShift;
		}

		Team getTeam(){
			return team;
		}

		bool IsAttackDisable(int i){
			return disableAttacks[i-1];
		}

		bool canMega(){
			return mega;
		}

		/*==========Setters===========*/
		void setConnected(bool connected){
			this.connected = connected;
		}

		void setWaitForSwitch(bool waitForSwitch){
			if(!this.waitForSwitch && waitForSwitch){
				incrementTurnShift();
			}
			this.waitForSwitch = waitForSwitch;
		}

		void setNeedRefreshTeam(bool needRefreshTeam){
			this.needRefreshTeam = needRefreshTeam;
		}

		void setPseudo(string pseudo){
			this.pseudo = pseudo;
		}

		void setBattleName(string battleName){
			this.battleName = battleName;
		}

		void setIdPlayer(int idPlayer){
			this.idPlayer = idPlayer;
		}

		void setTurn(int turn){
			this.turn = turn;
		}

		void incrementTurnShift(){
			incrementTurnShift(1);
		}

		void incrementTurnShift(int shift){
			setTurnShift(turnShift + shift);
		}

		void setTurnShift(int shift){
			turnShift = shift;
		}

		void setAttackDisable(int i, bool isDisable){
			disableAttacks[i] = isDisable;
		}

		void setCanMega(bool mega){
			this.mega = mega;
		}
	}
