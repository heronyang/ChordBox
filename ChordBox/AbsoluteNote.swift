//
//  AbsoluteNote.swift
//  ChordBox
//
//  Created by heron on 5/15/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import Foundation

class AbsoluteNote: CustomStringConvertible {
	
	let noteKey: String
	var accFlat: String?
	
	var description: String {
		if accFlat == nil {
			return "\(noteKey)"
		}
		return "\(noteKey)\(accFlat!)"
	}
	
	init(noteKey: String, accFlat: String?) {
		self.noteKey = noteKey
		self.accFlat = accFlat
	}
	
	init(rawData: String) {
		let matches = Helper.matchesForRegexInText(Constants.noteKeyRegex, text: rawData)
		self.noteKey = matches[0]
		self.accFlat = Helper.detectAccFlat(rawData)
	}
	
	func acc() {
		if accFlat == nil {
			accFlat = "#"
		} else if accFlat == "#" {
			accFlat = "##"
		} else if accFlat == "b" {
			accFlat = nil
		} else if accFlat == "x" {
			accFlat = "b"
		}else {
			accFlat = "!"
			print("error, not supported type")
		}
	}
	
	func flat() {
		if accFlat == nil {
			accFlat = "b"
		} else if accFlat == "#" {
			accFlat = nil
		} else if accFlat == "b" {
			accFlat = "x"
		} else if accFlat == "##" || accFlat == "%" {
			accFlat = "#"
		}else {
			accFlat = "!"
			print("error, not supported type")
		}
	}
	
}