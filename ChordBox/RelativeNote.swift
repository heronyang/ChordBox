//
//  Note.swift
//  ChordBox
//
//  Created by heron on 5/12/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import Foundation

class RelativeNote: CustomStringConvertible {
	
	let rawData: String
	
	let noteNumber: Int
	let flatAcc : String?
	
	var description: String {
		get {
			if flatAcc != nil {
				return "\(flatAcc!)\(noteNumber)"
			}
			return "\(noteNumber)"
		}
	}
	
	func getAbsoluteNote(key: String) -> AbsoluteNote {
		
		let absoluteNote:AbsoluteNote = AbsoluteNote(noteKey:"C", accFlat: "#")
		
		if flatAcc == "#" {
			absoluteNote.acc()
		} else if flatAcc == "b" {
			absoluteNote.flat()
		} else if flatAcc == "%" {
			absoluteNote.acc()
			absoluteNote.acc()
		} else if flatAcc == "x" {
			absoluteNote.flat()
			absoluteNote.flat()
		}
		
		return absoluteNote
		
	}
	
	init(rawData: String) {
		
		self.rawData = rawData
		
		if rawData.rangeOfString("#") != nil{
			self.flatAcc = "#"
		} else if rawData.rangeOfString("b") != nil {
			self.flatAcc = "b"
		} else if rawData.rangeOfString("%") != nil { // NOTE: % == ##
			self.flatAcc = "%"
		} else if rawData.rangeOfString("x") != nil {
			self.flatAcc = "x"
		} else {
			self.flatAcc = nil
		}

		let matches = Helper.matchesForRegexInText(Constants.noteNumberRegex, text: rawData)
		self.noteNumber = Int(matches[0])!
		
	}
	
}