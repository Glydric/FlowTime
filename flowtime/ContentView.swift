//
//  ContentView.swift
//  flowtime
//
//  Created by Leonardo Migliorelli on 31/10/22.
//
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var watch: StopWatch = StopWatch();
    var isOn = true;

    var body: some View {
        VStack {
            HStack {
                Button("Start", action: start)
                Button("Stop", action: stop)
                Button("Reset", action: reset)
            }
            Text("Durate \(watch.duration.hourMinuteSecond)")
            Text("Puoi riposarti per \(watch.pause.hourMinuteSecond)")
        }
                .padding()
    }

    func reset() {
        watch.reset();
    }

    func stop() {
        watch.stop();
    }

    func start() {
        watch.start();
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
