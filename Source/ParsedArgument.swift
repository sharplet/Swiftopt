//  Copyright (c) 2015 Adam Sharp. All rights reserved.

public enum ParsedArgument {
	case Switch(Bool)

	public var enabled: Bool? {
		switch self {
		case let .Switch(enabled):
			return enabled
		}
	}
}
