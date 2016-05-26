//
//  ChordProgression.swift
//  ChordBox
//
//  Created by heron on 5/10/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import Foundation

class ChordProgression: NSObject {
	
	let amount: Int
	let unit: Float
	var chordPlaceHolders = [ChordPlaceHolder]()
	
	override var description: String {
		var d = ""
		for chordPlaceHolder:ChordPlaceHolder in chordPlaceHolders {
			d += chordPlaceHolder.description + " "
		}
		return d
	}
	
	var descriptionForWatch: String {
		var d = ""
		var count = 0
		for chordPlaceHolder:ChordPlaceHolder in chordPlaceHolders {
			d += chordPlaceHolder.description
			if count % 4 == 3 {
				d += "\n"
			} else {
				d += " "
			}
			count += 1
		}
		return d
	}
	
	init(rawDataChordProgression: Dictionary<String, String>) {
		
		amount = Int(rawDataChordProgression["amount"]!)!
		unit = Float(rawDataChordProgression["unit"]!)!
		
		for i in 1...16 {
			
			let fieldName:String = "c" + String(i)
			let rawDataChord:String = rawDataChordProgression[fieldName]!
			
			if rawDataChord == "" {
				break
			}
			
			if Helper.isValidChordData(rawDataChord) {
				chordPlaceHolders.append(Chord(rawData: rawDataChord))
			}
			
			if Helper.isContinueSign(rawDataChord) {
				chordPlaceHolders.append(SucceedingChord())
			}
			
		}
		
	}
	
}