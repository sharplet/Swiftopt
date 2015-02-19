//  Copyright (c) 2015 Adam Sharp. All rights reserved.

extension String {
	private static func toUnsafeMutableCString(string: String) -> UnsafeMutablePointer<CChar> {
		return string.toUnsafeMutableCString()
	}

	private func toUnsafeMutableCString() -> UnsafeMutablePointer<CChar> {
		return cStringUsingEncoding(NSUTF8StringEncoding)
			.map(Array.toUnsafeMutablePointer)
		?? UnsafeMutablePointer<CChar>()
	}
}

extension Array {
	private static func toUnsafeMutablePointer(array: [T]) -> UnsafeMutablePointer<T> {
		return array.toUnsafeMutablePointer()
	}

	private func toUnsafeMutablePointer() -> UnsafeMutablePointer<T> {
		let pointer = UnsafeMutablePointer<T>.alloc(count)
		pointer.initializeFrom(self)
		return pointer
	}
}

func withUnsafeMutableCStrings<Result>(strings: [String], body: (Int32, UnsafePointer<UnsafeMutablePointer<CChar>>) -> Result) -> Result {
	let cstrings = strings.map(String.toUnsafeMutableCString).toUnsafeMutablePointer()

	let result = body(Int32(strings.count), UnsafePointer(cstrings))

	for (i, _) in enumerate(strings) {
		cstrings[i].destroy()
	}
	cstrings.destroy()

	return result
}
