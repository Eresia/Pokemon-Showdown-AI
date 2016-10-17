module ai.chooser.ou.ou_chooser;

import data.data_storage;

import ai.chooser.chooser;

abstract class OUChooser : Chooser {

	public:

		this(){
			super();
		}

		abstract int lead(DataStorage data);
}
