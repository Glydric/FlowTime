//
// Created by Leonardo Migliorelli on 03/11/22.
//

import Foundation
import AVFoundation

class SoundAlarm: Alarm {
    let soundFileURL = Bundle.main.url(forResource: "audio", withExtension: "wav")!

    func play() throws {
        do {
            let player = try AVAudioPlayer(contentsOf: soundFileURL)
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    override func update() {
        super.update()
        if (super.rawSeconds == 0) {
            try! play()
        }
    }

}