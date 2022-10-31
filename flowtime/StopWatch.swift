//
// Created by Leonardo Migliorelli on 31/10/22.
//

import Foundation

extension UInt64{
    var nsToSeconds: Int { Int(self) / 1000000000 }
}

class StopWatch: ObservableObject{
    var begin = DispatchTime.now();
    @Published var _duration: UInt64?;
    var duration: Int{
        (_duration ?? 0).nsToSeconds
    }


    public func start(){
        begin = DispatchTime.now();

    }

    public func updateDuration()  {
        _duration = DispatchTime.now().uptimeNanoseconds - begin.uptimeNanoseconds
    }
}