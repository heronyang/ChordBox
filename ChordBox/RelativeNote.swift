//
//  Note.swift
//  ChordBox
//
//  Created by heron on 5/12/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import Foundation

class RelativeNote: NSObject, NSCoding {
	
	let rawData: String
	
	let noteNumber: Int
	let accFlat : String?
	
	struct PropertyKey {
		static let rawDataKey = "rawData"
		static let noteNumberKey = "noteNumber"
		static let accFlat = "accFlat"
	}
	
	override var description: String {
		get {
			if accFlat != nil {
				return "\(accFlat!)\(noteNumber)"
			}
			return "\(noteNumber)"
		}
	}
	
	func getAbsoluteNote(key: String) -> AbsoluteNote {
		
		let keyScale = Constants.keyMap[Configuration.key]![noteNumber - 1]
		let absoluteNote:AbsoluteNote = AbsoluteNote(rawData: keyScale)
		
		if accFlat == "#" {
			absoluteNote.acc()
		} else if accFlat == "b" {
			absoluteNote.flat()
		} else if accFlat == "x" {
			absoluteNote.acc()
			absoluteNote.acc()
		} else if accFlat == "%" {
			absoluteNote.flat()
			absoluteNote.flat()
		}
		
		return absoluteNote
		
	}
	
	init(rawData: String) {
		
		self.rawData = rawData
		
		let matches = Helper.matchesForRegexInText(Constants.noteNumberRegex, text: rawData)
		self.noteNumber = Int(matches[0])!
		
		self.accFlat = Helper.detectAccFlat(rawData)

	}
	
	// MARK: NSCoding
	
	func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(rawData, forKey: PropertyKey.rawDataKey)
		aCoder.encodeObject(noteNumber, forKey: PropertyKey.noteNumberKey)
		aCoder.encodeObject(accFlat, forKey: PropertyKey.accFlat)
	}
	
	required convenience init?(coder aDecoder: NSCoder) {
		let rawData = aDecoder.decodeObjectForKey(PropertyKey.rawDataKey) as! String
		let noteNumber = aDecoder.decodeObjectForKey(PropertyKey.noteNumberKey) as! Int
		let accFlat = aDecoder.decodeObjectForKey(PropertyKey.accFlat) as! String?
		self.init(rawData: rawData, noteNumber: noteNumber, accFlat: accFlat)
	}
	
	init?(rawData: String, noteNumber: Int, accFlat: String?) {
		self.rawData = rawData
		self.noteNumber = noteNumber
		self.accFlat = accFlat
		super.init()
	}
	
}
