//
//  MasterViewController.swift
//  ChordBox
//
//  Created by heron on 5/10/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import UIKit
import SwiftCSV
import WatchConnectivity

class MasterViewController: UITableViewController, CallbackDelegate, WCSessionDelegate {
	
    var watchSession : WCSession?

	var detailViewController: DetailViewController? = nil
	private var chordProgressions = [ChordProgression]()
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		self.navigationItem.title = "All"
		
		let infoButton = UIBarButtonItem(title: "☰", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(showSettingPage(_:)))
		let playButton = UIBarButtonItem(title: "⚂⚄⚁", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(randomSelect(_:)))
		
		self.navigationItem.leftBarButtonItem = infoButton
		self.navigationItem.rightBarButtonItem = playButton
		
		if let split = self.splitViewController {
		    let controllers = split.viewControllers
		    self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
		}
		
		loadDataFromFile()
		
		setupWatchConnectivity()
		
	}
	
	func setupWatchConnectivity() {
		if(WCSession.isSupported()){
			watchSession = WCSession.defaultSession()
			watchSession!.delegate = self
			watchSession!.activateSession()
		} else {
			NSLog("WCSession is not supported")
		}
	}
	
	func sendRandomChordProgressionToWatch() {
		let message = chordProgressions[getRandomRowNumber()].descriptionForWatch
		do {
			try watchSession?.updateApplicationContext(
				["message" : message]
			)
		} catch let error as NSError {
			NSLog("Updating the context failed: " + error.localizedDescription)
		}
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
			NSLog("error in reading data file");
		}
	}
	
	func parseRawDataToLocal(rawData: [Dictionary<String, String>]) {
		
		for rawDataChordProgression: Dictionary<String, String> in rawData {
			
			let newChordProgression = ChordProgression(rawDataChordProgression: rawDataChordProgression)
			
			insertNewChordProgression(newChordProgression)
			insertNewChordProgressionToSharedChordData(newChordProgression)
			
		}
		
		saveNewChordProgressionsToSharedChordData()
		
	}
	
	func insertNewChordProgression(chordProgression: ChordProgression) {
		
		chordProgressions.insert(chordProgression, atIndex: 0)
		let indexPath = NSIndexPath(forRow: 0, inSection: 0)
		self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
		
	}
	
	func insertNewChordProgressionToSharedChordData(chordProgression: ChordProgression) {
	}
	
	func saveNewChordProgressionsToSharedChordData() {
	}
	
	func showSettingPage(sender: AnyObject) {
		performSegueWithIdentifier("showSettingPage", sender: self)
	}
	
	func randomSelect(sender: AnyObject) {
		let index = NSIndexPath(forRow: getRandomRowNumber(), inSection: 0);
		self.tableView.selectRowAtIndexPath(index, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
		performSegueWithIdentifier("showDetail", sender: self)
	}
	
	func getRandomRowNumber() -> Int {
		let diceRoll = Int(arc4random_uniform(UInt32(self.chordProgressions.count)) + 1)
		return diceRoll
	}
	
	// MARK: - Segues

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "showDetail" {
		    if let indexPath = self.tableView.indexPathForSelectedRow {
				let chordProgression = chordProgressions[indexPath.row]
		        let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
		        controller.chordProgression = chordProgression
		        controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
		        controller.navigationItem.leftItemsSupplementBackButton = true
		    }
		} else if segue.identifier == "showSettingPage" {
			let settingViewController = (segue.destinationViewController as! SettingViewController)
			settingViewController.delegate = self
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
		
		let bgColorView = UIView()
		bgColorView.backgroundColor = Helper.UIColorFromRGB(Constants.themeColor)
		cell.selectedBackgroundView = bgColorView
		
		return cell
	}

	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		return false
	}
	
	func reloadTable() {
		self.tableView.reloadData()
	}
	
	func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]){
		let message : String = applicationContext["message"] as! String
		NSLog(message)
		sendRandomChordProgressionToWatch()
	}

}

