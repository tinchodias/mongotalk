tests
testInsertWithWriteConcernError11000
	"Inserts two documents and verifies that inserting the second document
	violates a unique key constraint. Verify the document has NOT changed."

	| results concern |
	concern := MongoWriteConcern new w: 1; yourself.

	"Create an index with a unique key constraint."
	database command: ({
		'createIndexes' -> collection name.
		'indexes' -> {
			{	'key' -> { 'user_id' -> 1 } asDictionary.
				'unique' -> true.
				'name' -> 'unique_user_id'
			} as: OrderedDictionary }
		} as: OrderedDictionary).

	"Insert a valid value and assert it was added."
	collection
		commandInsert: { 'user_id' -> '1' } asDictionary
		writeConcern: concern.
	results := collection query: [ :query |  ].
	self assert: results size equals: 1.
	self assert: (results first at: 'user_id') equals: '1'.

	"Attempt to insert with a duplicate key"
	self
		should: [
			collection
				commandInsert:
					(Dictionary new
						at: 'user_id' put: '1';
						at: 'other' put: 3;
						yourself)
				writeConcern: concern ]
		raise: MongoCommandError
		withExceptionDo: [ :ex | 
			self assert: ex code equals: 11000.
			self assert: (ex errorMessage beginsWith: 
				'E11000 duplicate key error collection: ', collection qualifiedName) ].

	"Assert the insert was not performed"
	results := collection query: [ :query |  ].
	self assert: results size equals: 1.
	self deny: (results first includesKey: 'other')
