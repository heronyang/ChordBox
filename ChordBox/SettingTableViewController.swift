//
//  SettingTableViewController.swift
//  ChordBox
//
//  Created by heron on 5/15/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {
	
	/*
	override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
	if(self.tableView.respondsToSelector(Selector("setSeparatorInset:"))){
	self.tableView.separatorInset = UIEdgeInsetsZero
	}
	
	if(self.tableView.respondsToSelector(Selector("setLayoutMargins:"))){
	self.tableView.layoutMargins = UIEdgeInsetsZero
	}
	
	if(cell.respondsToSelector(Selector("setLayoutMargins:"))){
	cell.layoutMargins = UIEdgeInsetsZero
	}
	}
	*/
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		
		let s = indexPath.section
		let r = indexPath.row
		
		if s == 1 && r == 0 {
			openUrl("http://www.heron.me")
		} else if s == 1 && r == 1 {
			openUrl("http://pason-nosap-music-factory.weebly.com/")
		} else if s == 1 && r == 2 {
			openUrl("https://www.linkedin.com/in/wuning0219")
		}
	}
	
	func openUrl(url: String) {
		UIApplication.sharedApplication().openURL(NSURL(string: url)!)
	}
	
}
