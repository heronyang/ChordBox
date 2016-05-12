//
//  Chord.swift
//  ChordBox
//
//  Created by heron on 5/10/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import Foundation

class Chord: CustomStringConvertible {
	
	private let rawData: String!
	private let tonic: Note!
	private let decoration: String?
	private let inversion: Note?
	
	var description: String {
		var buf:String = self.tonic.description
		if self.decoration != nil {
			buf += ".\(self.decoration!)"
		}
		if self.inversion != nil {
			buf += "_\(self.inversion!.description)"
		}
		return buf
	}
	
	init(rawData: String) {
		
		self.rawData = rawData
		
		let chordMatches = Helper.matchesForRegexInText(Constants.noteRegex, text: self.rawData)
		let inversionMatches = Helper.matchesForRegexInText("/" + Constants.noteRegex, text: self.rawData)
		
		self.tonic = Note(rawData: chordMatches[0])
		
		var decorationHolder: String = self.rawData
		let toArray = decorationHolder.componentsSeparatedByString(chordMatches[0])
		decorationHolder = toArray.joinWithSeparator("")
		
		if !inversionMatches.isEmpty {
			self.inversion = Note(rawData: inversionMatches[0])
			let toArray2 = decorationHolder.componentsSeparatedByString(inversionMatches[0])
			decorationHolder = toArray2.joinWithSeparator("")
		} else {
			self.inversion = nil
		}
		
		if decorationHolder == "" {
			self.decoration = nil
		} else {
			self.decoration = decorationHolder
		}
		
	}
	
}