convenience
ifHasWaitAcknowledgment: aBlock
	^ waitAcknowledgment isEmptyOrNil ifFalse: [ 
		aBlock cull: waitAcknowledgment ]