//
// Created by Leonardo Migliorelli on 31/10/22.
//

import SwiftUI

struct RelaxView: View {
    @ObservedObject var alarm: Alarm;

    var body: some View {
        VStack {
            Text("Relaxing for \(alarm.seconds)").font(.title)
        }
                .frame(minWidth: WindowSize.width, minHeight: WindowSize.height)
                .padding(8)
    }//TODO relaxing view
}
