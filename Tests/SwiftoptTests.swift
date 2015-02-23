//  Copyright (c) 2015 Adam Sharp. All rights reserved.

import XCTest
import Assertions
import Swiftopt
import Runes

class SwiftoptTests: XCTestCase {
	func testItParsesSimpleFlags() {
		let result = Option("verbose") >>- { parse([$0], ["-v"])[$0] }
		assertEqual(result?.enabled, true)
	}

	func testItParsesCompactFlags() {
		let options = [Option("foo"), Option("bar")]
		let result = map(parse(catOptionals(options), ["-fb"])) { $1.enabled }
		assertEqual([true, true], catOptionals(result))
	}
}
