//  Copyright (c) 2015 Adam Sharp. All rights reserved.

import Darwin

public final class Option: Hashable, Printable {
	public let name: String
	public let shortName: UnicodeScalar
	public let longopt: option

	public init?(_ name: String, _ shortName: UnicodeScalar? = nil) {
		self.name = name

		if let firstCharacter = first(name.utf8).map({ UnicodeScalar($0) }) {
			self.shortName = shortName ?? firstCharacter
			self.longopt = option(name: self.name, has_arg: no_argument, flag: nil, val: Int32(self.shortName.value))
		}
		else {
			self.shortName = "\0"
			self.longopt = option()
			return nil
		}
	}

	public var hashValue: Int {
		return name.hashValue
	}

	public var description: String {
		return "Option(--\(name)/-\(shortName))"
	}
}

public func == (lhs: Option, rhs: Option) -> Bool {
	return lhs.name == rhs.name
}
