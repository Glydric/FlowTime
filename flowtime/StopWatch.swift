//
// Created by Leonardo Migliorelli on 31/10/22.
//

import Foundation

extension TimeInterval {
    var hourMinuteSecond: String {
        String(format: "%d:%02d:%02d", hour, minute, second)
    }
    var minuteSecond: String {
        hour == 0
                ? String(format: "%02d:%02d", minute, second)
                : hourMinuteSecond
    }
    var hour: Int {
        Int((self / 3600).truncatingRemainder(dividingBy: 3600))
    }
    var minute: Int {
        Int((self / 60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        Int(truncatingRemainder(dividingBy: 60))
    }
    var millisecond: Int {
        Int((self * 1000).truncatingRemainder(dividingBy: 1000))
    }
}


class StopWatch: ObservableObject {
    var timer = Timer();

    @Published private(set) var seconds: Int = 0;
    var duration: TimeInterval {
        TimeInterval(seconds)
    }
    var pause: TimeInterval {
        TimeInterval(seconds / 5)
    }

    @objc private func update() {
        seconds += 1;
    }

    public func reset() {
        seconds = 0
        stop()
    }

    public func stop() {
        timer.invalidate()
    }

    public func start() {
        stop()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
}