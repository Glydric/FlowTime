//
// Created by Leonardo Migliorelli on 31/10/22.
//

import SwiftUI

struct RelaxView: View {
	@StateObject private var viewModel: RelaxModel = RelaxModel()
	
	func calcFontTitle(size: CGSize) -> CGFloat {
		min(size.width / 4, size.height / 3)
	}
	
	var body: some View {
		GeometryReader { geometry in
			VStack {
				Text(viewModel.duration.minuteSecond)
					.font(.system(size: calcFontTitle(size: geometry.size)))
				if (viewModel.rawSeconds == 0) {
					Button(action: { ClockModel.shared.relaxingTime = 0 }) {
						Text("Nuova Sessione")
					}
				}
			}
			.padding(8)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
		}
		.frame(minWidth: MinWindowSize.width, minHeight: MinWindowSize.height)
		.onAppear(){
			viewModel.rawSeconds = ClockModel.shared.relaxingTime.allSeconds
		}
	}
	
}

