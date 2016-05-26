//
//  Chord.swift
//  ChordBox
//
//  Created by heron on 5/10/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import Foundation

class Chord: ChordPlaceHolder {
	
	private let rawData: String!
	private let tonic: RelativeNote!
	private let decoration: String?
	private let inversion: RelativeNote?
	
	private let key: String = Configuration.key// TODO: read system variable
	
	override var description: String {
		var buf: String = self.tonic.getAbsoluteNote(key).description
		if self.decoration != nil {
			buf += "\(self.decoration!)"
		}
		if self.inversion != nil {
			buf += "/\(self.inversion!.getAbsoluteNote(key).description)"
		}
		return buf
	}
	
	init(rawData: String) {
		
		self.rawData = rawData
		
		let chordMatches = Helper.matchesForRegexInText(Constants.noteRegex, text: self.rawData)
		let inversionMatches = Helper.matchesForRegexInText("/" + Constants.noteRegex, text: self.rawData)
		
		self.tonic = RelativeNote(rawData: chordMatches[0])
		
		let decorationStartIndex: Int = chordMatches[0].characters.count
		var decorationEndIndex: Int = rawData.characters.count
		
		if !inversionMatches.isEmpty {
			self.inversion = RelativeNote(rawData: inversionMatches[0])
			decorationEndIndex -= inversionMatches[0].characters.count
		} else {
			self.inversion = nil
		}
		
		self.decoration = rawData[rawData.startIndex.advancedBy(decorationStartIndex) ..< rawData.startIndex.advancedBy(decorationEndIndex)]
		
		print("\(decorationStartIndex) \(decorationEndIndex) \(rawData) \(self.tonic.description) \(self.decoration) \(self.inversion?.description ?? "")")
	}
	
	init?(rawData: String, tonic: RelativeNote, decoration: String, inversion: RelativeNote?) {
		
		self.rawData = rawData
		self.tonic = tonic
		self.decoration = decoration
		self.inversion = inversion
		
	}
	
}