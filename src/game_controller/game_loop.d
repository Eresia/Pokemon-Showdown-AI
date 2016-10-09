module game_loop;

import std.stdio;
import std.string;
import std.conv;
import core.thread;

import socket.network;
import socket.data_traitment;

import ai.ai_controller;
import ai.ai_action;

import input.manual_input;

class GameLoop : Thread{

	private:
		DataTraitment data;
		Network network;
		AIController ai;

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
					AIAction action = data.parseData(to!string(tempData));
					string result = ai.makeAction(action);
					if(result != null){
						network.sendData(result.dup);
					}
				}
			};

		}
	public:
		this(ushort port){
			super(&run);
			data = new DataTraitment();
			network = new Network(port);
			ai = new AIController(data);
			mi = new ManualInput(network);
		}



}
