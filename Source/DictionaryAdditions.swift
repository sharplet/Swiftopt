//  Copyright (c) 2015 Adam Sharp. All rights reserved.

extension Dictionary {
	init<S: SequenceType where S.Generator.Element == (Key, Value)>(_ entries: S) {
		self.init()
		for (key, value) in entries {
			self[key] = value
		}
	}
}
