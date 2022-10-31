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
    @State var isRunning = false;
    @State var isRelaxing = false;

    var body: some View {
//        isRelaxing ?
        VStack {
            Text("\(watch.duration.minuteSecond)")
                    .font(.title)
            HStack {
                isRunning ? Button("Stop", action: stop)
                        : Button("Start", action: start)
                Button("Reset", action: reset)
            }
                    .font(.title2)
            Button("Riposati per \(watch.pause.minuteSecond)", action: relax)
//        } : VStack {

        }
                .padding(8)
    }

    func relax() {
    }

    func reset() {
        watch.reset();
        isRunning = false;
    }

    func stop() {
        watch.stop();
        isRunning = false;
    }

    func start() {
        watch.start();
        isRunning = true;
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
