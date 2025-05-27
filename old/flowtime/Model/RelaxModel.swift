//
//  RelaxViewModel.swift
//  FlowTime
//
//  Created by Leonardo Migliorelli on 10/04/23.
//

import Foundation
import AVFAudio


class RelaxModel: ObservableObject {
	@Published private var timer: Timer = Timer()
	@Published var rawSeconds: Int = 0
	var duration: TimeInterval { TimeInterval(rawSeconds) }
	
	private let soundFileURL = Bundle.main.url(forResource: "audio", withExtension: "wav")!
	private let player: AVAudioPlayer
	
	init(_ duration: TimeInterval = ClockModel.shared.relaxingTime) {
		player = try! AVAudioPlayer(contentsOf: soundFileURL)
	}
	
	func start(){
		rawSeconds = ClockModel.shared.relaxingTime.allSeconds
		timer = Timer.scheduledTimer(
			withTimeInterval: 1,
			repeats: true,
			block: { [self] _ in
				decrement()
				if (rawSeconds == 0) {
					play()
				}
			}
		)
	}
	
	func decrement() {
		if rawSeconds == 0 {
			timer.invalidate()
		} else {
			rawSeconds -= 1
		}
	}
	
	func play() {
		player.prepareToPlay()
		player.play()
		ClockModel.shared.relaxingTime = 0
	}
}

