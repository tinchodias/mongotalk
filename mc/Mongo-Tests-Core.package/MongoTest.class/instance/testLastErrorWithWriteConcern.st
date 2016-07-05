tests
testLastErrorWithWriteConcern
	| data writeConcern |
	writeConcern := MongoWriteConcern new
		waitAcknowledgment: true;
		timeout: 2 seconds;
		journal: true;
		yourself.
		
	data := Dictionary new at: 'key' put: 'value'; yourself.
	collection add: data.
	
	self assert: (database lastError: writeConcern) ok