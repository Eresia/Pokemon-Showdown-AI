module ai.random_action_chooser;

import ai.action_chooser;
import ai.ai_action;

import data.data_storage;

abstract class RandomActionChooser : ActionChooser {

	protected :

	public:
		this(DataStorage data){
			super(data);
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
