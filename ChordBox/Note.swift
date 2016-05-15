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
	let absoluteFlatAcc : String?
	
	var key: String = Constants.defaultKey
	
	var description: String {
		get {
			if absoluteFlatAcc != nil {
				return "\(absoluteFlatAcc!)\(absoluteNumber)"
			}
			return "\(absoluteNumber)"
		}
	}
	
	init(rawData: String) {
		
		self.rawData = rawData
		
		if rawData.rangeOfString("#") != nil{
			self.absoluteFlatAcc = "#"
		} else if rawData.rangeOfString("b") != nil {
			self.absoluteFlatAcc = "b"
		} else if rawData.rangeOfString("%") != nil { // NOTE: % == ##
			self.absoluteFlatAcc = "%"
		} else if rawData.rangeOfString("x") != nil {
			self.absoluteFlatAcc = "x"
		} else {
			self.absoluteFlatAcc = nil
		}

		let matches = Helper.matchesForRegexInText(Constants.noteNumberRegex, text: rawData)
		self.absoluteNumber = Int(matches[0])!
		
	}
	
}