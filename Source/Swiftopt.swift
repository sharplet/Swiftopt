//  Copyright (c) 2015 Adam Sharp. All rights reserved.

public func parse(options: [Option], arguments: [String]) -> [Option: ParsedArgument] {
	let processName = Process.arguments.first ?? "Swiftopt"
	let argv = [processName] + arguments

	let prev_err = opterr
	opterr = 0

	let result = ArgumentParser(options, argv).parse()

	opterr = prev_err

	return result
}
