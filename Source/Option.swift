//  Copyright (c) 2015 Adam Sharp. All rights reserved.

import Darwin

public enum Option: Hashable, Printable {
	case Switch(String, UnicodeScalar, option)

	public init?(name: String) {
		if let shortName = first(name.utf8).map({ UnicodeScalar($0) }) {
			self = .Switch(
				name,
				shortName,
				option(name: name, has_arg: no_argument, flag: nil, val: Int32(shortName.value))
			)
		}
		else {
			return nil
		}
	}

	public var name: String {
		switch self {
		case let .Switch(name, _, _):
			return name
		}
	}

	public var shortName: UnicodeScalar {
		switch self {
		case let .Switch(_, shortName, _):
			return shortName
		}
	}

	public var longopt: option {
		switch self {
		case let .Switch(_, _, longopt):
			return longopt
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
