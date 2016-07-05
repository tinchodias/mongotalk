convenience
ifHasJournal: aBlock
	^ journal isEmptyOrNil ifFalse: [ 
		aBlock cull: journal ]