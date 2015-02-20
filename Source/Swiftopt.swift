//  Copyright (c) 2015 Adam Sharp. All rights reserved.

public func parse(options: [Option], arguments: [String]) -> [Option: ParsedArgument] {
	let processName = Process.arguments.first ?? "Swiftopt"
	let argv = [processName] + arguments

	var result = [Option: ParsedArgument]()

	withUnsafeMutableCStrings(argv) { (argc, argv) -> () in
		if let shortNames = "".join(options.map { String($0.shortName) }).cStringUsingEncoding(NSUTF8StringEncoding) {
			let longOptions = options.map { $0.longOption }

			let prev_err = opterr
			opterr = 0

			while let ord = .Some(getopt_long(argc, argv, shortNames, longOptions, nil)) where ord != -1 {
				let c = UnicodeScalar(UInt32(ord))

				if let option = find(options.map({ $0.shortName }), c).map({ options[$0] }) where c != "?" {
					result[option] = .Switch(true)
				}
			}

			opterr = prev_err
		}
	}

	return result
}
