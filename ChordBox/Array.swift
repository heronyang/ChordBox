//
//  Array.swift
//  ChordBox
//
//  Created by heron on 5/16/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

extension Array {
	func rotate(shift:Int) -> Array {
		var array = Array()
		if (self.count > 0) {
			array = self
			if (shift > 0) {
				for _ in 1...shift {
					array.append(array.removeAtIndex(0))
				}
			}
			else if (shift < 0) {
				for _ in 1...abs(shift) {
					array.insert(array.removeAtIndex(array.count-1),atIndex:0)
				}
			}
		}
		return array
	}
}