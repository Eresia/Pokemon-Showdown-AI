module socket.data_traitment;

import ai.ai_controller;
import ai.ai_action;

class DataTraitment {

	private:

	public:
		this(){

		}

		AIAction parseData(string data){
			return AIAction.UNKNOW;
		}

		int getTurn(){
			return 0;
		}

}
