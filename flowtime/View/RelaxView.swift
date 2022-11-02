//
// Created by Leonardo Migliorelli on 31/10/22.
//

import SwiftUI

struct RelaxView: View {
    @ObservedObject var alarm: Alarm;

    func calcFontTitle(size: CGSize) -> CGFloat {
        min(size.width / 4, size.height / 3)
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text(alarm.duration.minuteSecond)
                        .font(.system(size: calcFontTitle(size: geometry.size)))
            }
                    .padding(8)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
                .frame(minWidth: WindowSize.width, minHeight: WindowSize.height)
    }

}

