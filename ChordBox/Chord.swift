//
//  Chord.swift
//  ChordBox
//
//  Created by heron on 5/10/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import Foundation

class Chord: CustomStringConvertible {
	
	private let rawData: String
	private let Tonic: Note
	
	var description: String {
		return rawData;
	}
	
	init(rawData: String) {
		self.rawData = rawData
		self.Tonic = Note(rawData: "1")
	}
	
}