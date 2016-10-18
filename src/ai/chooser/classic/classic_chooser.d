module ai.chooser.classic.classic_chooser;

import data.data_storage;

import ai.chooser.chooser;

abstract class ClassicChooser : Chooser {

	public:

		this(){
			super();
		}

		abstract int lead(DataStorage data);
}
