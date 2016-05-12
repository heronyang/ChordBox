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
	static let chordRegex = "(#|b)?[1-7](M|m)?(6|7)?(sus|b5)?(\\/(#|b)?[1-7])?"
}