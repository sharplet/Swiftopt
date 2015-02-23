//  Copyright (c) 2015 Adam Sharp. All rights reserved.

func find<S: SequenceType>(elements: S, pred: S.Generator.Element -> Bool) -> S.Generator.Element? {
	for element in elements {
		if pred(element) {
			return element
		}
	}
	return nil
}
