module data.data_traitment;

import std.stdio;
import std.string;
import std.algorithm;
import std.conv;
import std.json;

import ai.ai_action;

import data.data_storage;
import data.pokemon.team;
import data.pokemon.pokemon_condition;

class DataTraitment {

	private:
		DataStorage dataStorage;

		char[][] tokenise(char[] input, char[] tokens)
		{
			char[][] res = null;
			int start = -1;

			foreach(int i, char c; input) {
				//if (tokens.find(c) == -1) {
				if(find(tokens, c) == ""){
					if (start == -1) start = i;
				}
				else {
					if (start != -1) {
						res ~= input[start..i];
						start = -1;
					}

				}
			}
			if (start != -1) res ~= input[start..$];
			return res;
		}

		AIAction updateData(char[][][] data){
			AIAction action = AIAction.UNKNOW;

			switch(data[1][0]){
				case "init":
					writeln("Subrequest : init");
					//dataStorage.setPseudo(to!string(data[5]));
					break;
				case "request":
					writeln("Subrequest : request");
					action = parseTeam(data[1][1]);

					break;
				case "player":
					writeln("Subrequest : player");
					if(data[1][1] == "p2"){
						writeln("Lead");
						action = AIAction.LEAD;
						writeln("Turn 1");
						dataStorage.setTurn(1);
					}
					break;
				case "choice":
					bool endOfFight = false;
					writeln("Subrequest : choice");

					for(int line = 2; line < data.length; line++){
						if(data[line].length > 0){
							switch(data[line][0]){
								case "turn":
									int turn = to!int(data[line][1]);
									writeln("Turn : ", turn);
									dataStorage.setTurn(turn);
									break;
								case "-damage":
									bool pokemonDead = (find(data[line][2], "fnt").length > 0);

									if(pokemonDead){
										dataStorage.setWaitForSwitch(true);
									}

									int idPlayer = to!int(data[line][1][1]);
									if(idPlayer == dataStorage.getIdPlayer()){
										if(pokemonDead){
											writeln("Pokemon Dead, force Switch");
											dataStorage.getTeam().getPokemon(1).setHP(0);
											dataStorage.setWaitForSwitch(true);
											action = AIAction.FORCE_SWITCH;
										}
										else{
											int newHP = to!int(tokenise(data[line][2], "/".dup)[0]);
											dataStorage.getTeam().getPokemon(1).setHP(newHP);
										}
									}
									break;
								case "win":
									writeln("End of Fight");
									endOfFight = true;
									break;
								default:

							}
						}
					}
					if(!endOfFight){
						if(!dataStorage.isWaitForSwitch()){
							writeln("Fight");
							action = AIAction.FIGHT;
						}
						else{
							dataStorage.setWaitForSwitch(false);
						}
					}
					else{
						action = AIAction.BEGIN;
					}
					break;
				default:
					writeln("Unknow subrequest");
			}

			return action;
		}

		AIAction parseTeam(char[] data){
			AIAction action = AIAction.UNKNOW;

			JSONValue parsed = parseJSON(data);

			/*******************************Parse Attacks*****************************/
			try{
				auto parsedAttacks = parsed["active"].array()[0]["moves"].array();
				for(int i = 0; i < PokemonCondition.NB_MAX_ATTACK; i++){
					bool disable;
					if(parsedAttacks.length <= i){
						disable = true;
					}
					else{
						try{
							writeln(parsedAttacks[i]["move"], " : isDisable ? : ", parsedAttacks[i]["disabled"].toString());
							if(parsedAttacks[i]["disabled"].toString() == "true"){
								disable = true;
							}
							else{
								disable = false;
							}
						}catch(JSONException e){
							disable = false;
						}
					}

					dataStorage.getActivePokemon().setAttackDisable(i, disable);
				}
			}catch(JSONException e){
				writeln("No active pokemon");
			}

			/*******************************Check Mega*****************************/
			bool canMega = false;

			try{
				if(parsed["active"].array()[0]["canMegaEvo"].toString() == "true"){
					writeln("Can Mega");
					canMega = true;
				}
				else{
					writeln("Can't Mega");
					canMega = false;
				}
			}catch(JSONException e){
				writeln("Can't Mega");
				canMega = false;
			}

			dataStorage.getActivePokemon().setCanMega(canMega);

			/*******************************Check Trapped*****************************/
			bool trapped = false;

			try{
				if(parsed["active"].array()[0]["trapped"].toString() == "true"){
					writeln("Is trapped");
					trapped = true;
				}
				else{
					writeln("Is not trapped");
					trapped = false;
				}
			}catch(JSONException e){
				writeln("Is not trapped");
				trapped = false;
			}

			dataStorage.getActivePokemon().setTrapped(trapped);

			/*******************************Refresh Team*****************************/
			if(dataStorage.isNeedRefreshTeam()){
				dataStorage.setNeedRefreshTeam(false);

				write("Force Switch ? : ");

				try{
					writeln(parsed["forceSwitch"].array()[0].toString());
					if(parsed["forceSwitch"].array()[0].toString() == "true"){
						dataStorage.setWaitForSwitch(true);
						action = AIAction.FORCE_SWITCH;
					}
					else{
						dataStorage.setWaitForSwitch(false);
					}
				} catch(JSONException e){
					writeln("false : ");
					dataStorage.setWaitForSwitch(false);
				}

				try{
					dataStorage.getTeam().cleanTeam();
					dataStorage.setPseudo(parsed["side"]["name"].str());

					string idPlayer = parsed["side"]["id"].str();
					dataStorage.setIdPlayer(to!int(idPlayer[1]));

					auto parsedTeam = parsed["side"]["pokemon"].array();
					for(int i = 0; i < Team.NB_MAX_POKEMON; i++){
						string id = parsedTeam[i]["ident"].str();
						string details = parsedTeam[i]["details"].str();
						string maxHPString = find(parsedTeam[i]["condition"].str(), "/");
						int maxHP = to!int(maxHPString[1..(maxHPString.length-1)]);
						PokemonCondition newPokemon = new PokemonCondition(id, details, maxHP, i+1);
						dataStorage.getTeam().addPokemon(newPokemon);
						/*if(parsedTeam[i]["active"].toString() == "true"){
							int active = to!int(dataStorage.getTeam().teamLength());
							dataStorage.setActivePokemon(active);
						}*/
					}

				} catch(JSONException e){
					writeln("ERROR IN REQUEST PARSING : ", e.msg);
				}
			}
			else{
				writeln("Not need refresh team");
			}

			return action;
		}

	public:
		this(DataStorage dataStorage){
			this.dataStorage = dataStorage;
		}

		AIAction parseData(string data){
			string separator = "|";
			AIAction action;

			if(data[0] == '>'){
				string divisorSeparator = ">";
				char[][] diviseRequest = tokenise(data.dup, divisorSeparator.dup);
				for(int j = 0; j < diviseRequest.length; j++){
					string halfSeparator = "\n";
					char[][] halfParsed = tokenise(diviseRequest[j], halfSeparator.dup);
					char[][][] parsed;
					for(int i = 0; i < halfParsed.length; i++){
						parsed ~= tokenise(halfParsed[i], separator.dup);
					}
					writeln("\n\nRequest : ", parsed[0][0]);

					dataStorage.setBattleName(to!string(parsed[0][0]));
					action = updateData(parsed);
				}
			}
			else{
				char[][] parsed = tokenise(data.dup, separator.dup);

				if(parsed.length != 0){
					writeln("\n\nRequest : ", parsed[0]);

					switch(parsed[0]){
						case "updateuser":
							if(find(parsed[1], "Guest") == ""){
								writeln("Launch battle");
								dataStorage.cleanInformation();
								action = AIAction.BEGIN;
							}
							else{
								dataStorage.setConnected(true);
								action = AIAction.UNKNOW;
							}
							break;
						case "init":
							writeln("Make initialisation");
							action = AIAction.UNKNOW;
							break;
						default:
							writeln("Not know the request");
							action = AIAction.UNKNOW;
					}
				}
			}


			return action;
		}

}
