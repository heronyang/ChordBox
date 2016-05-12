//
//  Note.swift
//  ChordBox
//
//  Created by heron on 5/12/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import Foundation

class Note: CustomStringConvertible {
	
	let rawData: String
	
	let absoluteNumber: Int
	let absoluteFlatAccidental: String
	
	var key: String = Constants.defaultKey
	
	var description: String {
		get {
			return self.rawData
		}
	}
	
	init(rawData: String) {
		self.rawData = rawData
		self.absoluteNumber = 1
		self.absoluteFlatAccidental = "#"
	}
	
}