module socket.network;

import std.stdio;
import std.string;
import std.socket;

class Network{

	private:
		ushort port;
		Socket socket;
		Socket client;

	public:

		this(ushort port = 8787){
			this.port = port;

			socket = new TcpSocket();
			socket.setOption(SocketOptionLevel.SOCKET, SocketOption.REUSEADDR, true);
			socket.bind(new InternetAddress(port));

		}

		int waitConnection(){
			writeln("Wait connexion");
			socket.listen(1);
			client = socket.accept();
			writeln("Connexion found");
			return 0;
		}

		long sendData(char[] data){
			writeln("Data send : ", data);
			return client.send(data);
		}

		char[] receiveData(){
			char[] data = new char[4096];
			auto result = client.receive(data);
			if(result == 0){
				return null;
			}
			//writeln("Result : ", result, "	Data received : ", data[0..result]);
			return data[0..result];
		}
}
