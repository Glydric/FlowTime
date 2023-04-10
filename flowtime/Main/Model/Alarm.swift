//
// Created by Leonardo Migliorelli on 02/11/22.
//

import Foundation
import AVFoundation

class Alarm: StopWatch {
	convenience init(_ duration: TimeInterval) {
		self.init(duration.allSeconds)
	}
	
	override init(_ duration: Int) {
		super.init(duration)
		start()
	}
	
	override func update() {
		decrement()
	}
}

class SoundAlarm: Alarm {
	private let soundFileURL = Bundle.main.url(forResource: "audio", withExtension: "wav")!
	private let player: AVAudioPlayer
	
	override init(_ duration: Int) {
		player = try! AVAudioPlayer(contentsOf: soundFileURL)
		super.init(duration)
	}
	
	func play() {
		player.prepareToPlay()
		player.play()
	}
	
	override func update() {
		super.update()
		if (super.rawSeconds == 0) {
			play()
		}
	}
	
}
