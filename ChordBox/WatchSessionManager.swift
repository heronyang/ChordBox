//
//  WatchSessionManager.swift
//  ChordBox
//
//  Created by heron on 5/16/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//


import WatchConnectivity

class WatchSessionManager: NSObject, WCSessionDelegate {
	
	static let sharedManager = WatchSessionManager()
	private override init() {
		super.init()
	}
	
	private let session: WCSession? = WCSession.isSupported() ? WCSession.defaultSession() : nil
	
	private var validSession: WCSession? {
		
		if let session = session where session.paired && session.watchAppInstalled {
			return session
		}
		
		return nil
		
	}
	
	func startSession() {
		session?.delegate = self
		session?.activateSession()
	}
}

// MARK: Application Context
// use when your app needs only the latest information
// if the data was not sent, it will be replaced
extension WatchSessionManager {
	
	// Sender
	func updateApplicationContext(applicationContext: [String : AnyObject]) throws {
		if let session = validSession {
			do {
				try session.updateApplicationContext(applicationContext)
				NSLog("throw context")
			} catch let error {
				NSLog("error in update application, WatchSessionManager")
				throw error
			}
		}
	}
	
	// Receiver
	func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
		// handle receiving application context
		
		dispatch_async(dispatch_get_main_queue()) {
			// make sure to put on the main queue to update UI!
			NSLog("get something (phone thread)")
		}
	}
	
	func sessionWatchStateDidChange(session: WCSession) {
		NSLog("session watch state change")
	}
	
	func sessionReachabilityDidChange(session: WCSession) {
		NSLog("reachability changed")
	}
	
}