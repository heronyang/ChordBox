//
//  SettingTableViewController.swift
//  ChordBox
//
//  Created by heron on 5/15/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
	
	let pickerDataSource = Array(Constants.keyMap.keys.sort().rotate(3))
 
	@IBOutlet weak var pickerView: UIPickerView!
	override func viewDidLoad() {
		super.viewDidLoad()
		self.pickerView.dataSource = self;
		self.pickerView.delegate = self;
	}
	
	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1
	}
 
	func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return pickerDataSource.count
	}
 
	func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return pickerDataSource[row]
	}
	
	func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		let selectedKey = pickerDataSource[row]
		Configuration.key = selectedKey
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		
		let s = indexPath.section
		let r = indexPath.row
		
		if s == 1 && r == 0 {
			Helper.openUrl("http://www.heron.me")
		} else if s == 1 && r == 1 {
			Helper.openUrl("http://pason-nosap-music-factory.weebly.com/")
		} else if s == 1 && r == 2 {
			Helper.openUrl("https://www.linkedin.com/in/wuning0219")
		}
		
	}
	
}
