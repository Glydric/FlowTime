//
//  ContentView.swift
//  flowtime
//
//  Created by Leonardo Migliorelli on 31/10/22.
//
//

import SwiftUI

enum WindowSize {
    static let width: CGFloat = 300;
    static let height: CGFloat = 200;
}

enum ButtonSize {
    static let width: CGFloat = WindowSize.width;
    static let height: CGFloat = WindowSize.height;
}

struct ContentView: View {
    @ObservedObject var watch: StopWatch = StopWatch();
    @State var isRunning = false;
    @State var isRelaxing = false;


    var body: some View {

//        isRelaxing ?
        VStack {
            Text("\(watch.duration.minuteSecond)")
                    .font(.system(size: 64))
            HStack {
                isRunning ? Button("Stop",action: stop)
                        : Button("Start", action: start)
                Button("Reset", action: reset)
            }
                    .font(.title)
            Button("Riposati per \(watch.pause.minuteSecond)", action: relax)
//        } : VStack {

        }
                .frame(minWidth: WindowSize.width, minHeight: WindowSize.height)
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
