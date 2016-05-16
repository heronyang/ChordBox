//
//  SharedChordData.swift
//  ChordBox
//
//  Created by heron on 5/16/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import Foundation

struct SharedChordData {
	
	private let defaultsKey = "chordProgressions"
	private let defaults = NSUserDefaults.standardUserDefaults()
	
	private var chordProgressions = [ChordProgression]()
	
	init() {
		chordProgressions = loadFromDefaults()
	}
	
	mutating func append(chordProgression: ChordProgression) {
		chordProgressions.append(chordProgression)
	}
	
	mutating func save() {
		saveToDefaults()
		print("SH: save")
	}
	
	mutating func clear() {
		clearAllInDefaults()
	}
	
	func saveToDefaults() {
		
		let encodedData: NSData = NSKeyedArchiver.archivedDataWithRootObject(chordProgressions)
		
		defaults.setObject(encodedData, forKey: defaultsKey)
		print(defaults.synchronize())
		print("SH: save to default")
		
	}
	
	func loadFromDefaults() -> [ChordProgression] {
		let decodedData = defaults.objectForKey(defaultsKey) as? NSData ?? nil
		if decodedData == nil {
			return []
		}
		let decodedArray = NSKeyedUnarchiver.unarchiveObjectWithData(decodedData!)
		return decodedArray as! [ChordProgression]
	}
	
	func clearAllInDefaults() {
		defaults.removeObjectForKey(defaultsKey)
	}
	
}