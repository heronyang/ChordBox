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
	func dataSourceDidUpdate(chordProgression: ChordProgression)
}

class WatchSessionManager: NSObject, WCSessionDelegate {
	
	static let sharedManager = WatchSessionManager()
	private override init() {
		super.init()
	}
	
	private var dataSourceChangedDelegates = [DataSourceChangedDelegate]()
	
	private let session: WCSession = WCSession.defaultSession()
	
	func startSession() {
		session.delegate = self
		session.activateSession()
	}
	
	func addDataSourceChangedDelegate<T where T: DataSourceChangedDelegate, T: Equatable>(delegate: T) {
		dataSourceChangedDelegates.append(delegate)
		print("data source add")
	}
	
	func removeDataSourceChangedDelegate<T where T: DataSourceChangedDelegate, T: Equatable>(delegate: T) {
		for (index, indexDelegate) in dataSourceChangedDelegates.enumerate() {
			if let indexDelegate = indexDelegate as? T where indexDelegate == delegate {
				dataSourceChangedDelegates.removeAtIndex(index)
				break
			}
		}
		print("data source removed")
	}
}

// MARK: Application Context
// use when your app needs only the latest information
// if the data was not sent, it will be replaced
extension WatchSessionManager {
	
	// Receiver
	func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
		
		dispatch_async(dispatch_get_main_queue()) { [weak self] in
			print("get something new")
			self?.dataSourceChangedDelegates.forEach {
				print("get something")
				let encodedData: NSData = applicationContext["chordProgression"] as! NSData
				let chordProgression: ChordProgression = NSKeyedUnarchiver.unarchiveObjectWithData(encodedData) as! ChordProgression
				$0.dataSourceDidUpdate(chordProgression)
			}
		}
		
	}
}