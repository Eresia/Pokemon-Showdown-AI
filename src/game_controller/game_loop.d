module game_loop;

import std.stdio;
import std.string;
import std.conv;
import core.thread;

import socket.network;
import data.data_storage;
import data.data_traitment;

import ai.action_chooser;
import ai.ai_controller_ou;
import ai.ai_action;

import input.manual_input;

class GameLoop : Thread{

	private:
		DataTraitment dataTraitment;
		DataStorage dataStorage;
		Network network;
		ActionChooser ai;

		ManualInput mi;

		void run(){
			char[] tempData;

			network.waitConnection();
			mi.start();
			while(true){
				tempData = network.receiveData();
				if(tempData == null){
					break;
				}
				else{
					AIAction action = dataTraitment.parseData(to!string(tempData));
					string[] result = ai.makeAction(action);
					if(result != null){
						foreach(string s; result){
							writeln("Send to server : ", s);
							network.sendData(s.dup);
						}
					}
				}
			};

		}
	public:
		this(ushort port){
			super(&run);
			dataStorage = new DataStorage();
			dataTraitment = new DataTraitment(dataStorage);
			network = new Network(port);
			ai = new AIControllerOU(dataStorage);
			mi = new ManualInput(network);
		}



}
