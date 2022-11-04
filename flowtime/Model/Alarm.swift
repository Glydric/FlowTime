//
// Created by Leonardo Migliorelli on 02/11/22.
//

import Foundation

public class Alarm: StopWatch {
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