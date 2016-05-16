//
//  Helper.swift
//  ChordBox
//
//  Created by heron on 5/12/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import UIKit

class Helper {
	
	static func matchesForRegexInText(regex: String!, text: String!) -> [String] {
		do {
			let regex = try NSRegularExpression(pattern: regex, options: [])
			let nsString = text as NSString
			let results = regex.matchesInString(text,
			                                    options: [], range: NSMakeRange(0, nsString.length))
			return results.map { nsString.substringWithRange($0.range)}
		} catch let error as NSError {
			print("invalid regex: \(error.localizedDescription)")
			return []
		}
	}
	
	static func isMatchedForRegexInText(regex: String!, text: String!) -> Bool {
		let matches  = matchesForRegexInText(regex, text: text)
		return matches.count > 0
	}
	
	static func isValidChordData(rawDataCord: String) -> Bool {
		return isMatchedForRegexInText(Constants.chordRegex, text: rawDataCord)
	}
	
	static func isContinueSign(rawDataCord: String) -> Bool {
		return rawDataCord == "-"
	}
	
	
	static func detectAccFlat(data: String) -> String? {
		
		if data.rangeOfString("#") != nil{
			return "#"
		} else if data.rangeOfString("b") != nil {
			return "b"
		} else if data.rangeOfString("%") != nil { // NOTE: % == ##
			return "%"
		} else if data.rangeOfString("x") != nil {
			return "x"
		}
		
		return nil
		
	}
	
	static func openUrl(url: String) {
		UIApplication.sharedApplication().openURL(NSURL(string: url)!)
	}
	
}