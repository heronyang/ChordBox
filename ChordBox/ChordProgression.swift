//
//  ChordProgression.swift
//  ChordBox
//
//  Created by heron on 5/10/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import Foundation

class ChordProgression: CustomStringConvertible {
	
	private let amount: Int
	private let unit: Float
	private var chords = [Chord]()
	
	var description: String {
		var d = ""
		for chord:Chord in chords {
			d += chord.description + " "
		}
		return d
	}
	
	init(rawDataChordProgression: Dictionary<String, String>) {
		amount = Int(rawDataChordProgression["amount"]!)!
		unit = Float(rawDataChordProgression["unit"]!)!
		print([amount, unit])
		for i in 1...16 {
			let fieldName:String = "c" + String(i)
			let rawDataChord:String = rawDataChordProgression[fieldName]!
			chords.append(Chord(rawData: rawDataChord))
		}
	}
	
}