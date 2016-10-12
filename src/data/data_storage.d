module data.data_storage;

import data.pokemon.team;

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
		int activePokemon;

	public:
		this(){
			connected = false;
		 	pseudo = "Guest";
			team = new Team();
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
			activePokemon = 0;
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

		int getActivePokemon(){
			return activePokemon;
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

		void setActivePokemon(int activePokemon){
			this.activePokemon = activePokemon;
		}
	}
