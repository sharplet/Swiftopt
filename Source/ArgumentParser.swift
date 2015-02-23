//  Copyright (c) 2015 Adam Sharp. All rights reserved.

import Darwin
import Runes

public final class ArgumentParser {
	public init(_ options: [Option], _ arguments: [String]) {
		argv = arguments
		opts = options
		shortopts = Option.shortOptionString(options)
		longopts = map(options) { opt in
			option(name: opt.name, has_arg: no_argument, flag: nil, val: Int32(opt.shortName.value))
		}
	}

	func parse() -> [Option: ParsedArgument] {
		let old_optind = optind
		optreset = 1
		let parseResults = GeneratorOf { self.step() }
		let parsed = Dictionary(parseResults)
		optind = old_optind
		return parsed
	}

	func step() -> (Option, ParsedArgument)? {
		currentParseResult = withUnsafeMutableCStrings(argv) { argc, argv in
			getopt_long(argc, argv, self.shortopts, self.longopts, nil)
		}
		return parsedArgument()
	}

	private func parsedArgument() -> (Option, ParsedArgument)? {
		return currentChar >>- { c in
			switch c {
			case "?":
				return nil
			default:
				if let found = find(self.opts, { $0.name.hasPrefix(c) }) {
					return (found, ParsedArgument(found))
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

	private let opts: [Option]
	private let argv: [String]
	private let shortopts: String
	private var longopts: [option] = []
	private var currentParseResult: Int32 = -1
}
