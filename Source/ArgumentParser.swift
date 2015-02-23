//  Copyright (c) 2015 Adam Sharp. All rights reserved.

import Darwin
import Runes

public final class ArgumentParser: SequenceType {
	public init(_ options: [Option], _ arguments: [String]) {
		argv = arguments
		shortopts = Option.shortOptionString(options)
		longopts = map(options) { opt in
			option(name: opt.name, has_arg: no_argument, flag: nil, val: Int32(opt.shortName.value))
		}
		self.options = options
	}

	func step() -> (Option, ParsedArgument)? {
		currentParseResult = withUnsafeMutableCStrings(argv) { argc, argv in
			getopt_long(argc, argv, self.shortopts, self.longopts, nil)
		}
		return parsedArgument()
	}

	func parse() -> [Option: ParsedArgument] {
		let old_optind = optind
		optreset = 1
		let parsed: [Option: ParsedArgument] = reduce(self, [:]) { (var result, each) in
			result[each.0] = each.1
			return result
		}
		optind = old_optind
		return parsed
	}

	private func parsedArgument() -> (Option, ParsedArgument)? {
		return currentChar >>- { c in
			switch c {
			case "?":
				return nil
			default:
				if let found = find(self.options, { $0.name.hasPrefix(c) }) {
					return (found, ParsedArgument.Switch(!found.enabledByDefault))
				}
				return nil
			}
		}
	}

	private var currentChar: String? {
		if currentParseResult == -1 {
			return nil
		}

		return String(UnicodeScalar(UInt32(currentParseResult)))
	}

	public func generate() -> GeneratorOf<(Option, ParsedArgument)> {
		return GeneratorOf { self.step() }
	}

	private let options: [Option]
	private let argv: [String]
	private let shortopts: String
	private var longopts: [option] = []
	private var currentParseResult: Int32 = -1
}
