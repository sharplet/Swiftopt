//  Copyright (c) 2015 Adam Sharp. All rights reserved.

import Darwin

public enum Option: Hashable, Printable {
	case Switch(String, UnicodeScalar, Bool)

	public static func shortOptionString(options: [Option]) -> String {
		return join("", options.map { $0.shortOptionString })
	}

	public init?(_ name: String, enabledByDefault: Bool = false) {
		if let shortName = first(name.utf8).map({ UnicodeScalar($0) }) {
			self = .Switch(
				name,
				shortName,
				enabledByDefault
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

	public var enabledByDefault: Bool {
		switch self {
		case let .Switch(_, _, enabledByDefault):
			return enabledByDefault
		}
	}

	public var shortOptionString: String {
		return String(shortName)
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
