tests - read preference
testGlobalReadPreferencePrimaryCommand

	| selected topology |
	self timeLimit: 30 seconds.
	
	client := MongoSDAMClient withUrls: {
		MongoReplicationTestResources mongoUrlA }.

	client readPreference: MongoReadPreference primary.

	"Start monitoring and wait a bit until reaching Steady state."
	client steadyStateFrequency: 3 seconds.
	client start.
	100 milliSeconds wait.

	"Server A is the primary."
	topology := client topology.
	self assert: topology hasWritableServer.
	self assert: topology isTypeReplicaSetWithPrimary.
	self assert: topology primaryUrl equals: MongoReplicationTestResources mongoUrlA.

	"It writes to primary (A)"
	self doCommandWriteOnClient.

	"It reads from primary (A)"
	selected := self doCommandReadOnClient.
	self assert: selected size equals: 1.

	"Step down server A and force Crisis state in client."
	MongoReplicationTestResources stepDownA: 10 seconds.
	client restart.
	1 second wait.

	"It can't do a read command from the secondary (B)"
	self
		should: [ self doCommandReadOnClient ]
		raise: MongoCommandError.