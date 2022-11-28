//
//  ContentView.swift
//  flowtime
//
//  Created by Leonardo Migliorelli on 31/10/22.
//
//

import SwiftUI

enum MinWindowSize {
    static let width: CGFloat = 350;
    static let height: CGFloat = 250;
}

struct MainView: View {
    @ObservedObject var watch: StopWatch = StopWatch();
    @Binding var relaxingTime: TimeInterval;
    @Binding var total: TimeInterval;
    @Binding var record: TimeInterval;
    var updatedTotal: TimeInterval {
        total.advanced(by: watch.duration)
    }
    var updatedRecord: TimeInterval {
        record.allSeconds < watch.duration.allSeconds
                ? watch.duration
                : record
    }

    var watchButton: Button<TupleView<(Image, Text)>> {
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
    }
    var resetButton: Button<TupleView<(Image, Text)>> {
        Button(action: watch.reset, label: {
            Image(systemName: "gobackward")
            Text("Reset")
        })
    }
    var relaxingButton: Button<TupleView<(Image, Text)>> {
        Button(action: endSession) {
            Image(systemName: "cup.and.saucer.fill")
            Text("Riposati per \(watch.relaxDuration.minuteSecond)")
        }
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Totale - \(total.minuteSecond)").font(.title2)
                Text("Record - \(updatedRecord.minuteSecond)").font(.title2)
//                Text("\(Int(geometry.size.width))x\(Int(geometry.size.height)) \(Int(calcFontTitle(size: geometry.size)))")
                Text("\(watch.duration.minuteSecond)")
                        .font(Font.custom(
                                "Monaco",
//                                TODO add ConcertOne-Regular.ttf
                                size: calcFontTitle(size: geometry.size)
                        )).padding(8)

                HStack {
                    watchButton
                    resetButton
                }
                relaxingButton
            }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
                .frame(minWidth: MinWindowSize.width, minHeight: MinWindowSize.height)
    }

    func calcFontTitle(size: CGSize) -> CGFloat {
        min(size.width / 4.5, size.height / 3)
    }

    func endSession() {
        if watch.relaxDuration == 0 {
            return
        }
        relaxingTime = watch.relaxDuration
        total = updatedTotal
        record = updatedRecord
    }

}