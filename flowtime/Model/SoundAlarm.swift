//
// Created by Leonardo Migliorelli on 03/11/22.
//

import Foundation
import AVFoundation

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
