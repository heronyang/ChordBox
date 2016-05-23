//
//  InterfaceController.swift
//  Watch Extension
//
//  Created by heron on 5/16/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController, DataSourceChangedDelegate {
	
	@IBOutlet var randomButton: WKInterfaceButton!
	
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
		WatchSessionManager.sharedManager.addDataSourceChangedDelegate(self)
		NSLog("will deactivete")
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
		WatchSessionManager.sharedManager.removeDataSourceChangedDelegate(self)
		NSLog("did deactivete")
        super.didDeactivate()
    }

	@IBAction func randomButtonOnTapped() {
		NSLog("tapped")
        do {
            try WatchSessionManager.sharedManager.updateApplicationContext(["command": "getRandomChordProgression"])
        } catch {
			NSLog("error")
        }
	}
	
	// MARK: DataSourceUpdatedDelegate
	func dataSourceDidUpdate(data: NSString) {
		// let chordProgression = NSKeyedUnarchiver.unarchiveObjectWithData(encodedChordProgression) as! ChordProgression
		randomButton.setTitle(data as String!)
		NSLog("get something here \(data)")
	}
	
}
