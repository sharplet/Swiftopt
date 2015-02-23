//  Created by Adam Sharp on 23/02/2015.

func catOptionals<T>(optionals: [T?]) -> [T] {
	return optionals.reduce([]) { result, each in
		each.map { result + [$0] } ?? result
	}
}
