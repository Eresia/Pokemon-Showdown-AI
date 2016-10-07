module main.main;

import std.stdio;
import std.string;
import std.conv;

import socket.network;
import input.manual_input;

int main(string[] args){

	Network net = new Network(8787);
	char[] data;
	net.waitConnection();

	ManualInput mi = new ManualInput(net);
	mi.start();
	while(true){
		data = net.receiveData();
		if(data == null){
			break;
		}
	};

	return 0;
}
