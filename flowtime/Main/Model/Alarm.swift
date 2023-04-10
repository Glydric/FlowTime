//
// Created by Leonardo Migliorelli on 02/11/22.
//

import Foundation
import AVFoundation

class SoundAlarm: StopWatch {
	private let soundFileURL = Bundle.main.url(forResource: "audio", withExtension: "wav")!
	private let player: AVAudioPlayer
	
	convenience init(_ duration: TimeInterval) {
		self.init(duration.allSeconds)
	}
	
	override init(_ duration: Int) {
		player = try! AVAudioPlayer(contentsOf: soundFileURL)
		super.init(duration)
		start()
	}
	
	func play() {
		player.prepareToPlay()
		player.play()
	}
	
	override func update() {
		decrement()
		if (super.rawSeconds == 0) {
			play()
		}
	}
	
}
