//
//  Constants.swift
//  ChordBox
//
//  Created by heron on 5/12/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import Foundation

struct Constants {
	
	static let noteRegex = "(#|b)?[1-7]"
	static let noteNumberRegex = "[1-7]"
	static let noteKeyRegex = "[A-G]"
	static let noteFlatAcc = "[#|b|%|x]"
	static let chordRegex = "(#|b|%|x)?[1-7](M|m)?(6|7)?(sus|b5)?(\\/(#|b|%|x)?[1-7])?"
	
	static let defaultKey = "G#/Ab"
	static let keyMap = [
		"C": ["C", "D", "E", "F", "G", "A", "B"],
		"C#/Db": ["Db", "Eb", "F", "Gb", "Ab", "Bb", "C"],
		"D": ["D", "E", "F#", "G", "A", "B", "C#"],
		"D#/Eb": ["Eb", "F", "G", "Ab", "Bb", "C", "D"],
		"E": ["E", "F#", "G#", "A", "B", "C#", "D#"],
		"F": ["F", "G", "A", "Bb", "C", "D", "E"],
		"F#/Gb": ["Gb", "Ab", "Bb", "Cb", "Db", "Eb", "F", "Gb"],
		"G": ["G", "A", "B", "C", "D", "E", "F#"],
		"G#/Ab": ["Ab", "Bb", "C", "Db", "Eb", "F", "G", "Ab"],
		"A": ["A", "B", "C#", "D", "E", "F#", "G#"],
		"A#/Bb": ["Bb", "C", "D", "Eb", "F", "G", "A", "Bb"],
		"B": ["B", "C#", "D#", "E", "F#", "G#", "A#"]
	]
	static let printableAccFlatSymbols = ["#": "♯", "b": "♭", "##": "𝄪", "bb": "𝄫"]
	
}