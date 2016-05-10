//
//  Chord.swift
//  ChordBox
//
//  Created by heron on 5/10/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import Foundation

class Chord: CustomStringConvertible {
	
	private var name: String = "C"
	
	var description: String {
		return name;
	}
	
	init(name: String) {
		self.name = name
	}
	
}