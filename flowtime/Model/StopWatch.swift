//
// Created by Leonardo Migliorelli on 31/10/22.
//

import Foundation

class StopWatch: ObservableObject {
    private var timer = Timer()
    @Published private(set) var seconds: Int

    init(_ seconds: Int) {
        self.seconds = seconds
    }

    convenience init() {
        self.init(0)
    }

    var duration: TimeInterval {
        TimeInterval(seconds)
    }

    @objc func update() {
        increment()
    }

    func increment() {
        seconds += 1
    }

    func decrement() {
        seconds -= 1

        if (seconds == 0) {
            stop()
        }
    }

    var relaxDuration: TimeInterval {
        TimeInterval(seconds / 5)
    }

    public func stop() {
        timer.invalidate()
    }

    public func reset() {
        seconds = 0
        stop()
    }

    public func start() {
        // riavvia il timer
        stop()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
}