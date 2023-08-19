//
//  ContentView.swift
//  flowtime
//
//  Created by Leonardo Migliorelli on 31/10/22.
//
//

import SwiftUI

struct ClockView: View {
	@StateObject private var viewModel: ClockModel = ClockModel.shared
	
	var resetButton: Button<TupleView<(Image, Text)>> {
		Button(action: viewModel.reset, label: {
			Image(systemName: "gobackward")
			Text("Reset")
		})
	}
	
	var body: some View {
		GeometryReader { geometry in
			VStack {
//				Text("Totale ~ \(viewModel.actualTotal.minuteSecond)").font(.title2)
//				Text("Record ~ \(viewModel.actualRecord.minuteSecond)").font(.title2)
				// Text("\(Int(geometry.size.width))x\(Int(geometry.size.height)) \(Int(calcFontTitle(size: geometry.size)))")
				Text(viewModel.duration.minuteSecond)
					.font(Font.custom(
						"Monaco",
						// TODO add ConcertOne-Regular.ttf
						size: calcFontTitle(size: geometry.size)
					)).padding(8)
				
				HStack {
					if viewModel.isPaused{
						Button(action: viewModel.start, label: {
							Image(systemName: "play.fill")
							Text("Start")
						})
					} else {
						Button(action: viewModel.endSession, label: {
							Image(systemName: "cup.and.saucer.fill")
							
							Text("Relax for \(viewModel.relaxDuration.minuteSecond)")
						})
					}
					resetButton
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
		}
		.frame(minWidth: MinWindowSize.width, minHeight: MinWindowSize.height)
	}
	
	func calcFontTitle(size: CGSize) -> CGFloat {
		min(size.width / 4.5, size.height / 3)
	}
}

enum MinWindowSize {
	static let width: CGFloat = 350;
	static let height: CGFloat = 250;
}
