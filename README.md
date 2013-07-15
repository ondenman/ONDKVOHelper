#ONDKVOHelper


Convenience class. Register keys for KVO with fewer lines of code.

##Usage

You are writing a class that requires the observation of several values. An instance of ONDKVOHelper will save you time.

* Populate an NSDictionary object with keys to be observed and methods to be called when observed values change.
* Initialize ONDKVOHelper with dictionary object and reference to self.
	
    NSDictionary *keysAndMethods = [NSDictionary dictionaryWithObjectsAndKeys:
	                                    @"thomasValueHasChanged",@"thomas",
	                                    @"percyValueHasChanged",@"percy",
	                                    @"gordonValueHasChanged",@"gordon",
	                                    @"networkControllerValueHasChanged",@"isControllerFat",
	                                    nil];
