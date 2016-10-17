module ai.chooser.chooser;

import data.data_storage;

abstract class Chooser {

	public:

		this(){}

		abstract string fight(DataStorage data);
		abstract int forceSwitch(DataStorage data);
}
