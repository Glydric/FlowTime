//
//  ContentView.swift
//  flowtime
//
//  Created by Leonardo Migliorelli on 31/10/22.
//
//

import SwiftUI

enum DefaultWindowSize {
    static let width: CGFloat = 350;
    static let height: CGFloat = 250;
}

struct MainView: View {
    @ObservedObject var watch: StopWatch = StopWatch();
    @Binding var relaxingTime: TimeInterval;
    @State var total: TimeInterval = 0;

    var body: some View {
        GeometryReader { geometry in
            VStack {
//                Text("\(Int(geometry.size.width))x\(Int(geometry.size.height)) \(Int(calcFontTitle(size: geometry.size)))")
                Text("\(watch.duration.minuteSecond)")
                        .font(.system(size: calcFontTitle(size: geometry.size)))
                HStack {
                    watch.isPaused ?
                            Button(action: watch.start, label: {
                                Image(systemName: "play.fill")
                                Text("Start")
                            })
                            :
                            Button(action: watch.stop, label: {
                                Image(systemName: "pause.fill")
                                Text("Pause")
                            })
                    Button(action: watch.reset, label: {
                        Image(systemName: "gobackward")
                        Text("Reset")
                    })
                }
                Button(action: beginRelaxing) {
                    Image(systemName: "cup.and.saucer.fill")
                    Text("Riposati per \(watch.relaxDuration.minuteSecond)")
                }
                Text("Somma sessioni \(total.hourMinuteSecond)")
            }
                    .padding(8)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
                .frame(minWidth: DefaultWindowSize.width, minHeight: DefaultWindowSize.height)
    }

    func calcFontTitle(size: CGSize) -> CGFloat {
        min(size.width / 4, size.height / 3)
    }

    func beginRelaxing() {
        total = total.advanced(by: watch.relaxDuration)
        relaxingTime = watch.relaxDuration
        watch.reset()
    }

}