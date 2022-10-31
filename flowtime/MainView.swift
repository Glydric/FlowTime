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

var isRelaxing = false;

struct MainView: View {
    @ObservedObject var watch: StopWatch = StopWatch();
    @State var isRunning = false;


    var body: some View {

        VStack {
            Text("\(watch.duration.minuteSecond)")
                    .font(.system(size: 64))
            HStack {
                isRunning ? Button(action: stop, label: {
                    Image(systemName: "pause")
                    Text("Pause")
                })
                        : Button(action: start, label: {
                    Image(systemName: "play")
                    Text("Start")
                })
                Button(action: reset, label: {
                    Image(systemName: "arrow.uturn.backward")
                    Text("Reset")
                })
            }
//                    .font(.title)
            Button("Riposati per \(watch.pause.minuteSecond)", action: relax)

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
        MainView()
    }
}
