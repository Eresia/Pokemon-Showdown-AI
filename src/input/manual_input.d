module input.manual_input;

import std.stdio;
import std.string;
import std.conv;
import core.thread;
import socket.network;

class ManualInput : Thread{

	private:
		Network net;

		void run(){
			string inp;

			while(true){
				inp = takeInput();
				if(inp == "q"){
					break;
				}
				net.sendData(inp.dup);
			};
		}

		string takeInput(){
			return strip(stdin.readln());
		}

	public:

		this(Network net){
			super(&run);
			this.net = net;
		}

		~this(){

		}
}
