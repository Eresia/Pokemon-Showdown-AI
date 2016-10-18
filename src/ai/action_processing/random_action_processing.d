module ai.action_processing.random_action_processing;

import ai.action_processing.action_processing;
import ai.ai_action;

import ai.chooser.chooser;

import data.data_storage;

abstract class RandomActionProcessing : ActionProcessing {

	protected :

	public:
		this(DataStorage data, Chooser chooser){
			super(data, chooser);
		}

		override string[] makeAction(AIAction action){
			string[] result;
			switch(action){
				case AIAction.BEGIN:
					result = beginBattle();
					break;
				case AIAction.FIGHT:
					result = fight();
					break;
				case AIAction.FORCE_SWITCH:
					result = forceSwitch();
					break;
				default:
					result = null;
			}

			return result;
		}
}
