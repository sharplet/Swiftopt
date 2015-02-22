//  Copyright (c) 2015 Adam Sharp. All rights reserved.

final class UnsafeMutablePointerBox<T>: Printable {
	init(_ value: T) {
		pointer = UnsafeMutablePointer.alloc(1)
		pointer.initialize(value)
	}

	let pointer: UnsafeMutablePointer<T>

	var value: T {
		return pointer.memory
	}

	var description: String {
		return "MutableBox(\(toString(value)))"
	}

	deinit {
		pointer.destroy()
	}
}
