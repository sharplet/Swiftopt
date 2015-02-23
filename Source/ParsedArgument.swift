//  Copyright (c) 2015 Adam Sharp. All rights reserved.

public enum ParsedArgument {
	case Switch(Bool)
	case Required(String)

	public init?(_ option: Option, argument: String? = nil) {
		switch option {
		case let .Switch(_, _, enabledByDefault):
			self = .Switch(!enabledByDefault)
		case .Required:
			if let argument = argument {
				self = .Required(argument)
			}
			else {
				return nil
			}
		}
	}

	public var enabled: Bool? {
		switch self {
		case let .Switch(enabled):
			return enabled
		default:
			return nil
		}
	}

	public var argument: String? {
		switch self {
		case let .Required(argument):
			return argument
		default:
			return nil
		}
	}
}
