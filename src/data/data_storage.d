module data.data_storage;

import data.pokemon.team;
import data.pokemon.pokemon_condition;
import data.pokemon.active_pokemon;

class DataStorage {

	private:

		bool connected;
		bool needRefreshTeam;
		string pseudo;
		string battleName;
		int idPlayer;
		int rqid;

		Team team;
		ActivePokemon activePokemon;

	public:
		this(){
			connected = false;
		 	pseudo = "Guest";
			team = new Team();
			activePokemon = new ActivePokemon();
			cleanInformation();
		}

		void cleanInformation(){
			battleName = "Not defined";
			needRefreshTeam = true;
			idPlayer = -1;
			team.cleanTeam();
			activePokemon.cleanInformation();
		}

		/*==========Getters===========*/
		bool isConnected(){
			return connected;
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

		Team getTeam(){
			return team;
		}

		ActivePokemon getActivePokemon(){
			return activePokemon;
		}

		int getRqid(){
			return rqid;
		}

		/*==========Setters===========*/
		void setConnected(bool connected){
			this.connected = connected;
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

		void setRqid(int rqid){
			this.rqid = rqid;
		}
	}
