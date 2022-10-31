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
    var timer = Timer();
    var begin = Date.now;
    @Published private(set) var duration = 0;

    init(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }


//    var duration: Int{
//
//    }

    @objc func update() {
        duration+=1;
    }
    public func start(){
//        begin = Date.now;
        print(timer.isValid)
    }
}