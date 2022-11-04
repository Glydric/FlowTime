//
// Created by Leonardo Migliorelli on 31/10/22.
//

import Foundation

class StopWatch: ObservableObject {
    private(set) var timer: Timer
    @Published private(set) var rawSeconds: Int
    @Published var isPaused: Bool = false;

    var duration: TimeInterval {
        TimeInterval(rawSeconds)
    }

    init(_ seconds: Int) {
        rawSeconds = seconds
        timer = Timer()
        updateIsPaused()
    }

    convenience init() {
        self.init(0)
    }


    @objc func update() {
        increment()
    }

    func increment() {
        rawSeconds += 1
    }

    func decrement() {
        if (rawSeconds == 0) {
            stop()
        } else {
            rawSeconds -= 1
        }
    }

    var relaxDuration: TimeInterval {
        TimeInterval(rawSeconds / 5)
    }

    public func stop() {
        timer.invalidate()
        updateIsPaused()
    }

    public func reset() {
        rawSeconds = 0
        stop()
    }

    public func start() {
        // riavvia il timer
        stop()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        updateIsPaused()
    }

    public func updateIsPaused() {
        isPaused = !timer.isValid
    }
}