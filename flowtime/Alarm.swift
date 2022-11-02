//
// Created by Leonardo Migliorelli on 02/11/22.
//

import Foundation

class Alarm: ObservableObject {
    private var timer = Timer()
    @Published private(set) var seconds: TimeInterval;

    convenience init(_ seconds: Int) {
        self.init(TimeInterval(seconds));
    }

    init(_ seconds: TimeInterval) {
        self.seconds = seconds;
        start()
    }

    @objc private func update() {
    }

    public func start() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
}