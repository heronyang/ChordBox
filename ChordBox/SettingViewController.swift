//
//  SettingViewController.swift
//  ChordBox
//
//  Created by heron on 5/15/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
	
	var delegate: CallbackDelegate?
	
	override func viewWillDisappear(animated: Bool) {
		self.delegate?.reloadTable()
	}

}