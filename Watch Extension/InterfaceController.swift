//
//  InterfaceController.swift
//  Watch Extension
//
//  Created by heron on 5/16/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
	
	var watchSession : WCSession?
	
	@IBOutlet var mainLabel: WKInterfaceLabel!
	
	func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]){
		let message : String = applicationContext["message"] as! String
		mainLabel.setText(message)
	}
	
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
		
		NSLog("will deactivete")
		if(WCSession.isSupported()){
			watchSession = WCSession.defaultSession()
			// Add self as a delegate of the session so we can handle messages
			watchSession!.delegate = self
			watchSession!.activateSession()
		}
		
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
		NSLog("did deactivete")
        super.didDeactivate()
    }

	@IBAction func randomButtonOnTapped() {
		NSLog("tapped")
		sendRandomMessage()
	}
	
	func sendRandomMessage() {
		
		NSLog("session status \(watchSession?.reachable), \(watchSession?.activationState)")
		
		if let message : String = NSDate().description {
			do {
				try watchSession?.updateApplicationContext(
					["message" : message]
				)
			} catch let error as NSError {
				NSLog("Updating the context failed: " + error.localizedDescription)
			}
		}
	}
	
}
