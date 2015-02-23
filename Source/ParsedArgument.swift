//  Copyright (c) 2015 Adam Sharp. All rights reserved.

public enum ParsedArgument {
	case Switch(Bool)

	public init(_ option: Option) {
		switch option {
		case let .Switch(_, _, enabledByDefault):
			self = .Switch(!enabledByDefault)
		}
	}

	public var enabled: Bool? {
		switch self {
		case let .Switch(enabled):
			return enabled
		}
	}
}
