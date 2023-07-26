//
//  MainViewModel.swift
//  FlowTime
//
//  Created by Leonardo Migliorelli on 10/04/23.
//

import Foundation


class ClockModel: ObservableObject {
	static let shared: ClockModel = ClockModel() // TODO implement as macro
	
	@Published private(set) var timer: Timer
	@Published private var rawSeconds: Int
	@Published var relaxingTime: TimeInterval = 0
	
	var isPaused: Bool { !timer.isValid }

	var duration: TimeInterval { TimeInterval(rawSeconds) }
	var relaxDuration: TimeInterval { TimeInterval(rawSeconds / 5) }
	
	var actualTotal: TimeInterval {
		StorageManager.actualProfile.total.advanced(by: duration)
	}
	
	var actualRecord: TimeInterval {
		max(duration, StorageManager.actualProfile.record)
	}
	
	private init(_ seconds: Int = 0) {
		rawSeconds = seconds

		timer = Timer()
	}

	func endSession() {
		if relaxDuration != 0 {
			StorageManager.actualProfile.total = actualTotal
			StorageManager.actualProfile.record = actualRecord
			relaxingTime = relaxDuration
			reset()
		}
	}
	
	public func stop() {
		timer.invalidate()
	}
	
	public func reset() {
		rawSeconds = 0
		stop()
	}
	
	/// avvia il timer
	public func start() {
		stop()
		timer = Timer.scheduledTimer(
			timeInterval: 1,
			target: self,
			selector: #selector(increment),
			userInfo: nil,
			repeats: true
		)
	}
	
	@objc func increment() {
		rawSeconds += 1
	}
}

