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
		var buf: String = self.tonic.description
		if self.decoration != nil {
			buf += "\(self.decoration!)"
		}
		if self.inversion != nil {
			buf += "\(self.inversion!.description)"
		}
		return buf
	}
	
	init(rawData: String) {
		
		self.rawData = rawData
		
		let chordMatches = Helper.matchesForRegexInText(Constants.noteRegex, text: self.rawData)
		let inversionMatches = Helper.matchesForRegexInText("/" + Constants.noteRegex, text: self.rawData)
		
		self.tonic = Note(rawData: chordMatches[0])
		
		let decorationStartIndex: Int = chordMatches[0].characters.count
		var decorationEndIndex: Int = rawData.characters.count
		
		if !inversionMatches.isEmpty {
			self.inversion = Note(rawData: inversionMatches[0])
			decorationEndIndex -= inversionMatches[0].characters.count
		} else {
			self.inversion = nil
		}
		
		self.decoration = rawData[rawData.startIndex.advancedBy(decorationStartIndex) ..< rawData.startIndex.advancedBy(decorationEndIndex)]
		
		print("\(decorationStartIndex) \(decorationEndIndex) \(rawData) \(self.tonic.description) \(self.decoration) \(self.inversion?.description ?? "")")
	}
	
}