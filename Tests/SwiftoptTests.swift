//  Copyright (c) 2015 Adam Sharp. All rights reserved.

import XCTest
import Assertions
import Swiftopt
import Runes

class SwiftoptTests: XCTestCase {
	func testItParsesSimpleFlags() {
		let result = Option("verbose", "v") >>- { parse([$0], ["-v"])[$0] }
		assertEqual(result?.enabled, true)
	}
}
