private
newOsProcess
	^ OSSUnixSubprocess new
		command: 'mongod';
		arguments: self mongodArguments;
		redirectStdout;
		redirectStderr;
		terminateOnShutdown;
		yourself