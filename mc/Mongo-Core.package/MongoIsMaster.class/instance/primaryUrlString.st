replica set
primaryUrlString
	^ response at: 'primary' ifAbsent: [ '' ]