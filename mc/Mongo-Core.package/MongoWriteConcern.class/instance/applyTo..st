convenience
applyTo: aDictionary

	self ifHasJournal: [ :value | aDictionary at: 'j' put: value ].
	self ifHasWaitAcknowledgment: [ :value | aDictionary at: 'w' put: value ].
	self ifHasTimeout: [ :value | aDictionary at: 'wtimeout' put: value ].
