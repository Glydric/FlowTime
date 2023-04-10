//
//  MainViewModel.swift
//  FlowTime
//
//  Created by Leonardo Migliorelli on 10/04/23.
//

import Foundation

extension ClockView {
	class Model: ObservableObject {
		@Published private var timer: Timer
		@Published private(set) var rawSeconds: Int
		var isPaused: Bool {
			!timer.isValid
		}

		var progress: ProgressModel
		var duration: TimeInterval { TimeInterval(rawSeconds) }
		var relaxDuration: TimeInterval { TimeInterval(rawSeconds / 5) }
		
		var total: TimeInterval {
			progress.total.advanced(by: duration)
		}
		
		var record: TimeInterval {
			progress.record.allSeconds < duration.allSeconds
				? duration
				: progress.record
		}
		
		init(_ seconds: Int = 0) {
			rawSeconds = seconds
			
			progress = StorageManager.progress
			
			timer = Timer()
		}

		func endSession() {
			if relaxDuration != 0 {
				progress.total = total
				progress.record = record
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
}
