//
//  Constants.swift
//  ChordBox
//
//  Created by heron on 5/12/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import Foundation

struct Constants {
	static let defaultKey = "C"
	static let noteRegex = "(#|b)?[1-7]"
	static let noteNumberRegex = "[1-7]"
	static let noteFlatAcc = "[#|b|%|x]"
	static let chordRegex = "(#|b|%|x)?[1-7](M|m)?(6|7)?(sus|b5)?(\\/(#|b|%|x)?[1-7])?"
}