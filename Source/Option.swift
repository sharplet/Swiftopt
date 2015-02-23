//  Copyright (c) 2015 Adam Sharp. All rights reserved.

import Darwin

public enum Option: Hashable, Printable {
	case Switch(String, UnicodeScalar, Bool)
	case Required(String, UnicodeScalar)

	public static func shortName(name: String) -> UnicodeScalar? {
		return first(name.utf8).map { UnicodeScalar($0) }
	}

	public static func shortOptionString(options: [Option]) -> String {
		return join("", options.map { $0.shortOptionString })
	}

	public init?(flag name: String, enabledByDefault: Bool = false) {
		if let shortName = Option.shortName(name) {
			self = .Switch(name, shortName, enabledByDefault)
		}
		else {
			return nil
		}
	}

	public init?(_ name: String, required: Bool) {
		if let shortName = Option.shortName(name) where required {
			self = .Required(name, shortName)
		}
		else {
			return nil
		}
	}

	public var name: String {
		switch self {
		case let .Switch(name, _, _):
			return name
		case let .Required(name, _):
			return name
		}
	}

	public var shortName: UnicodeScalar {
		switch self {
		case let .Switch(_, shortName, _):
			return shortName
		case let .Required(_, shortName):
			return shortName
		}
	}

	public var hasArgument: Int32 {
		switch self {
		case .Switch:
			return no_argument
		case .Required:
			return required_argument
		}
	}

	public var enabledByDefault: Bool? {
		switch self {
		case let .Switch(_, _, enabledByDefault):
			return enabledByDefault
		case .Required:
			return nil
		}
	}

	public var shortOptionString: String {
		switch self {
		case let .Required(_, shortName):
			return "\(shortName):"
		default:
			return String(shortName)
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
