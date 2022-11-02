//
// Created by Leonardo Migliorelli on 01/11/22.
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