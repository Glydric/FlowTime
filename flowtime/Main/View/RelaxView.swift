//
// Created by Leonardo Migliorelli on 31/10/22.
//

import SwiftUI

struct RelaxView: View {
	@Binding var relaxingTime: TimeInterval
	@ObservedObject private var alarm: Alarm;
	
	init(time: Binding<TimeInterval>) {
		self._relaxingTime = time
		alarm = SoundAlarm(time.wrappedValue)
	}
	
	func calcFontTitle(size: CGSize) -> CGFloat {
		min(size.width / 4, size.height / 3)
	}
	
	var body: some View {
		GeometryReader { geometry in
			VStack {
				Text(alarm.duration.minuteSecond)
					.font(.system(size: calcFontTitle(size: geometry.size)))
				if (alarm.rawSeconds == 0) {
					Button(action: { relaxingTime = 0 }) {
						Text("Nuova Sessione")
					}
				}
			}
			.padding(8)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
		}
		.frame(minWidth: MinWindowSize.width, minHeight: MinWindowSize.height)
	}
	
}

