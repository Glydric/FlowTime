//
// Created by Leonardo Migliorelli on 03/11/22.
//

import Foundation
import AVFoundation

class SoundAlarm: Alarm {
    private let soundFileURL = Bundle.main.url(forResource: "audio", withExtension: "wav")!
    private let player: AVAudioPlayer

    override init(_ duration: Int) {
        do {
            player = try! AVAudioPlayer(contentsOf: soundFileURL)
        } catch let error {
            print(error.localizedDescription)
        }
        super.init(duration)
    }

    func play() {
        player.prepareToPlay()
        print(player.play())
    }

    override func update() {
        super.update()
        if (super.rawSeconds == 0) {
            play()
        }
    }

}
