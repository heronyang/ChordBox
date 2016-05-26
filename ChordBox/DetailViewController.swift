//
//  DetailViewController.swift
//  ChordBox
//
//  Created by heron on 5/10/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

	@IBOutlet weak var detailDescriptionLabel: UILabel!


	var chordProgression: ChordProgression? {
		didSet {
		    self.configureView()
		}
	}

	func configureView() {
		if let chordProgression = self.chordProgression {
			var index = 0
			for view in self.view.subviews as [UIView] {
				if let label = view as? UILabel {
					let labelText = "\(getChordDescriptionAtIndex(index, chordProgression: chordProgression))"
					if labelText == "" {
						label.hidden = true
					} else {
						label.hidden = false
						label.text = labelText
					}
					index += 1
				}
			}
		}
	}
	
	func getChordDescriptionAtIndex(index: Int, chordProgression: ChordProgression) -> String {
		let amount = chordProgression.amount
		let unit = chordProgression.unit
		
		if amount == 4 && unit == 1 {
			if index >= 4 && index <= 7 {
				return chordProgression.chordPlaceHolders[index-4].description
			}
		}
		
		if (amount == 4 && unit == 0.5) || (amount == 8 && unit == 1){
			if index >= 4 && index <= 11 {
				return chordProgression.chordPlaceHolders[index-4].description
			}
		}
		
		if (amount == 8 && unit == 0.5) {
			return chordProgression.chordPlaceHolders[index].description
		}
		
		return ""
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.configureView()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

