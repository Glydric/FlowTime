//
// Created by Leonardo Migliorelli on 02/11/22.
//

import Foundation

class Alarm: StopWatch {
    convenience init(_ duration: TimeInterval) {
        self.init(duration.second)
    }

    init(_ duration: Int) {
        super.init()
        super.seconds = duration
        start()
    }

    override func update() {
        super.seconds -= 1

        if (seconds == 0) {
            stop()
        }
    }
}