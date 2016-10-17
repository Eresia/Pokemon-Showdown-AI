module ai.classic_action_chooser;

import ai.action_chooser;
import ai.ai_action;
import ai.chooser.ou.ou_chooser;

import data.data_storage;

abstract class ClassicActionChooser : ActionChooser {

	protected :
		abstract string[] lead();

	public:
		this(DataStorage data, OUChooser chooser){
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
