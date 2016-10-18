module ai.action_processing.classic_action_processing;

import ai.action_processing.action_processing;
import ai.ai_action;
import ai.chooser.classic.classic_chooser;

import data.data_storage;

abstract class ClassicActionProcessing : ActionProcessing {

	protected :
		abstract string[] lead();

	public:
		this(DataStorage data, ClassicChooser chooser){
			super(data, chooser);
		}

		override string[] makeAction(AIAction action){
			string[] result;
			switch(action){
				case AIAction.BEGIN:
					result = beginBattle();
					break;
				case AIAction.LEAD:
					result = lead();
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
