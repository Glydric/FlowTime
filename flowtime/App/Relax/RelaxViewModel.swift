//
//  RelaxViewModel.swift
//  FlowTime
//
//  Created by Leonardo Migliorelli on 10/04/23.
//

import Foundation
import AVFAudio

extension RelaxView {
	class Model: ObservableObject {
		@Published private var timer: Timer = Timer()
		@Published var rawSeconds: Int
		var duration: TimeInterval { TimeInterval(rawSeconds) }
		
		private let soundFileURL = Bundle.main.url(forResource: "audio", withExtension: "wav")!
		private let player: AVAudioPlayer
		
		convenience init(_ duration: TimeInterval) {
			self.init(duration.allSeconds)
		}
		
		init(_ duration: Int = 0) {
			player = try! AVAudioPlayer(contentsOf: soundFileURL)
			rawSeconds = duration
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
		}
		
	}
}
