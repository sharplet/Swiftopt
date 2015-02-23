//  Created by Adam Sharp on 23/02/2015.

func catOptionals<T>(optionals: [T?]) -> [T] {
	return optionals.reduce([]) {
		$1 == nil ? $0 : $0 + [$1!]
	}
}
