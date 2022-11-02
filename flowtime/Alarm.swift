//
// Created by Leonardo Migliorelli on 02/11/22.
//

import Foundation

class Alarm: StopWatch {
    convenience init(_ duration: TimeInterval) {
        self.init(duration.second)
    }

    override init(_ duration: Int) {
        super.init(duration)
        start()
    }

    override func update() {
        decrement()
    }
}