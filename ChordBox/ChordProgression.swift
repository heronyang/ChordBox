//
//  ChordProgression.swift
//  ChordBox
//
//  Created by heron on 5/10/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import Foundation

class ChordProgression: CustomStringConvertible {
	
	private var chords = [Chord]()
	
	var description: String {
		var d = ""
		for chord:Chord in chords {
			d += chord.description
		}
		return d
	}
	
	init() {
		let chord = Chord(name: "C")
		for _ in 0...8 {
			chords.append(chord)
		}
	}
	
}