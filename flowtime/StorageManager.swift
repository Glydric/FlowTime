//
//  StorageManager.swift
//  FlowTime
//
//  Created by Leonardo Migliorelli on 10/04/23.
//

import SwiftUI

class StorageManager {
	
//	static var actualRecord: TimeInterval {
//		get {
//			actualProfile.record
//		}
//		set {
//			var pro = actualProfile
//			pro.record = newValue
//			actualProfile = pro
//		}
//	}
	
	static var actualProfile: Profile {
		get {
			let count = StorageManager.profile.count
			guard count > 0 else { return Profile() }
			guard StorageManager().actualProfileId <= count else { return StorageManager.profile[0] }
			
			return StorageManager.profile[StorageManager().actualProfileId]
		}
		set {
			let index = StorageManager.profile.firstIndex(of: newValue) ?? 0
			// save the id of the actual profile
			StorageManager().actualProfileId = index
			
			// replace same index with newValue, as it might be changed (this happens with total and record updates)
			StorageManager.profile.replace(newValue, at: index)
		}
	}
	
	@AppStorage("actual")
	private var actualProfileId = 0
	
	@AppStorage("profilesString")
	static var profile = [Profile]()
}
