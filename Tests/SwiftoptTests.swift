//  Copyright (c) 2015 Adam Sharp. All rights reserved.

import XCTest
import Assertions
import Swiftopt
import Runes

class SwiftoptTests: XCTestCase {
	func testItParsesSimpleFlags() {
		let result = Option(flag: "verbose") >>- {
			parse([$0], ["-v"])[$0]
		}
		assertEqual(result?.enabled, true)
	}

	func testItParsesCompactFlags() {
		let options = [Option(flag: "foo"), Option(flag: "bar")]
		let result = map(parse(catOptionals(options), ["-fb"])) {
			$1.enabled
		}
		assertEqual([true, true], catOptionals(result))
	}

	func testItParsesRequiredArguments() {
		let options = [Option("foo", required: true)]
		let result = map(parse(catOptionals(options), ["-f", "bar"])) {
			$1.argument
		}
		assertEqual(["bar"], catOptionals(result))
	}
}
