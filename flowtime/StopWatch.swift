//
// Created by Leonardo Migliorelli on 31/10/22.
//

import Foundation

extension TimeInterval {
    var hourMinuteSecondMS: String {
        String(format:"%d:%02d:%02d.%03d", hour, minute, second, millisecond)
    }
    var minuteSecondMS: String {
        String(format:"%d:%02d.%03d", minute, second, millisecond)
    }
    var hour: Int {
        Int((self/3600).truncatingRemainder(dividingBy: 3600))
    }
    var minute: Int {
        Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        Int(truncatingRemainder(dividingBy: 60))
    }
    var millisecond: Int {
        Int((self*1000).truncatingRemainder(dividingBy: 1000))
    }
}


class StopWatch: ObservableObject{
    var begin = Date.now;
    @Published var _duration: TimeInterval?;
    var duration: Int{
        (_duration ?? 0).second
    }


    public func start(){
        begin = Date.now;

    }

    public func updateDuration()  {
        _duration = begin.distance(to: Date.now)
    }
}