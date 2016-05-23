//
//  WatchSessionManager.swift
//  ChordBox
//
//  Created by heron on 5/16/16.
//  Copyright © 2016 Heron Yang. All rights reserved.
//

import Foundation

import WatchConnectivity

protocol DataSourceChangedDelegate {
	func dataSourceDidUpdate(encodedChordProgression: NSString)
}

class WatchSessionManager: NSObject, WCSessionDelegate {
	
	static let sharedManager = WatchSessionManager()
	private override init() {
		super.init()
	}
	
	private var dataSourceChangedDelegates = [DataSourceChangedDelegate]()
	
	private let session: WCSession? = WCSession.isSupported() ? WCSession.defaultSession() : nil
	private var validSession: WCSession? {
		return session
	}
	
	func addDataSourceChangedDelegate<T where T: DataSourceChangedDelegate, T: Equatable>(delegate: T) {
		dataSourceChangedDelegates.append(delegate)
		NSLog("data source add")
	}
	
	func removeDataSourceChangedDelegate<T where T: DataSourceChangedDelegate, T: Equatable>(delegate: T) {
		for (index, indexDelegate) in dataSourceChangedDelegates.enumerate() {
			if let indexDelegate = indexDelegate as? T where indexDelegate == delegate {
				dataSourceChangedDelegates.removeAtIndex(index)
				break
			}
		}
		NSLog("data source removed")
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
		
        dispatch_async(dispatch_get_main_queue()) { [weak self] in
            self?.dataSourceChangedDelegates.forEach { $0.dataSourceDidUpdate(applicationContext["data"] as! NSString)}
        }
		
	}
}