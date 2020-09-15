external projects
taskIt: spec
	spec project: 'TaskIt' with: [
		spec
			repository: 'github://pharo-contributions/taskit:v1.1.0';
			loads: #(minimal) ]
