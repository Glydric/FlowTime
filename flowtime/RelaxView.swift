//
// Created by Leonardo Migliorelli on 31/10/22.
//

import SwiftUI

struct RelaxView: View {
    let time: TimeInterval;

    var body: some View {
        VStack {
            Text("Relaxing for \(time)").font(.title)
        }
                .frame(minWidth: WindowSize.width, minHeight: WindowSize.height)
                .padding(8)
    }
}
