//
//  ChordProgression.swift
//  ChordBox
//
//  Created by heron on 5/10/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import Foundation

class ChordProgression: NSObject, NSCoding {
	
	private let amount: Int
	private let unit: Float
	private var chords = [Chord]()
	
	struct PropertyKey {
		static let amountKey = "amount"
		static let unitKey = "unit"
		static let chordsKey = "chords"
	}
	
	override var description: String {
		var d = ""
		for chord:Chord in chords {
			d += chord.description + " "
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
				chords.append(Chord(rawData: rawDataChord))
			}
			
		}
		
	}
	
	// MARK: NSCoding
	
	func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(amount, forKey: PropertyKey.amountKey)
		aCoder.encodeObject(unit, forKey: PropertyKey.unitKey)
		aCoder.encodeObject(chords, forKey: PropertyKey.chordsKey)
	}
	
	required convenience init?(coder aDecoder: NSCoder) {
		let amount = aDecoder.decodeObjectForKey(PropertyKey.amountKey) as! Int
		let unit = aDecoder.decodeObjectForKey(PropertyKey.unitKey) as! Float
		let chords = aDecoder.decodeObjectForKey(PropertyKey.chordsKey) as! [Chord]
		
		self.init(amount: amount, unit: unit, chords: chords)
	}
	
	init?(amount: Int, unit: Float, chords: [Chord]) {
		self.amount = amount
		self.unit = unit
		self.chords = chords
		
		super.init()
	}
	
}