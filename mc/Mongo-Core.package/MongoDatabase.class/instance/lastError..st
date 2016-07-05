operations
lastError: aMongoWriteConcern
	"Answer the result of getLastError mongodb command. 
	
	See more: https://docs.mongodb.com/manual/reference/command/getLastError
	"

	| reply dictionary |
	dictionary := Dictionary new.
	dictionary at: 'getLastError' put: 1.
	aMongoWriteConcern applyTo: dictionary.
	reply := self command: dictionary.
	
	^ MongoLastError newFor: reply