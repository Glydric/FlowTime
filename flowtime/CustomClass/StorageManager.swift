//
//  StorageManager.swift
//  FlowTime
//
//  Created by Leonardo Migliorelli on 10/04/23.
//

import Foundation

class StorageManager {
	
	static var progress: ProgressModel {
		get {
			guard
				let data = StorageManager().progressString.data(using: .utf8)
			else { return ProgressModel() }
			
			return try! JSONDecoder().decode(ProgressModel.self, from: data)
		}
		set {
			StorageManager().progressString = newValue.asJson!
		}
	}
	
	private var progressString: String {
		set {
			UserDefaults.standard.set(newValue, forKey: "progressString")
		}
		get {
			UserDefaults.standard.string(forKey: "progressString") ?? ProgressModel().asJson!
		}
	}
}
