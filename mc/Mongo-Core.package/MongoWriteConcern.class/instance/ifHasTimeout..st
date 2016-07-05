convenience
ifHasTimeout: aBlock
	^ timeout isEmptyOrNil ifFalse: [ 
		aBlock cull: timeout ]