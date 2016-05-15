//
//  MasterViewController.swift
//  ChordBox
//
//  Created by heron on 5/10/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import UIKit
import SwiftCSV

class MasterViewController: UITableViewController {

	var detailViewController: DetailViewController? = nil
	var chordProgressions = [ChordProgression]()


	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationItem.title = "All"
		
		let infoButton = UIBarButtonItem(title: "☰", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(showSettingPage(_:)))
		let playButton = UIBarButtonItem(title: "♫", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(randomSelect(_:)))
		
		self.navigationItem.leftBarButtonItem = infoButton
		self.navigationItem.rightBarButtonItem = playButton
		
		if let split = self.splitViewController {
		    let controllers = split.viewControllers
		    self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
		}
		
		loadDataFromFile()
		
	}
	
	override func viewWillAppear(animated: Bool) {
		self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
		super.viewWillAppear(animated)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func loadDataFromFile() {
		do {
			let fileLocation = NSBundle.mainBundle().pathForResource("chordData", ofType: "csv")!
			let csv = try CSV(name: fileLocation)
			parseRawDataToLocal(csv.rows.reverse())
		} catch {
			print("error in reading data file");
		}
	}
	
	func parseRawDataToLocal(rawData: [Dictionary<String, String>]) {
		for rawDataChordProgression: Dictionary<String, String> in rawData {
			insertNewChordProgression(ChordProgression(rawDataChordProgression: rawDataChordProgression))
		}
	}

	func showSettingPage(sender: AnyObject) {
		performSegueWithIdentifier("ShowSettingPage", sender: self)
	}
	
	func randomSelect(sender: AnyObject) {
		
	}
	
	func insertNewChordProgression(chordProgression: ChordProgression) {
		chordProgressions.insert(chordProgression, atIndex: 0)
		let indexPath = NSIndexPath(forRow: 0, inSection: 0)
		self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
	}

	// MARK: - Segues

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "showDetail" {
		    if let indexPath = self.tableView.indexPathForSelectedRow {
				let chordProgression = chordProgressions[indexPath.row]
		        let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
		        controller.detailItem = chordProgression
		        controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
		        controller.navigationItem.leftItemsSupplementBackButton = true
		    }
		}
	}
	
	// MARK: - Table View

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return chordProgressions.count
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

		let chordProgression = chordProgressions[indexPath.row]
		cell.textLabel!.text = chordProgression.description
		
		return cell
	}

	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return true
	}


}

