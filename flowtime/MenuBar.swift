//
//  MenuBar.swift
//  FlowTime
//
//  Created by Leonardo Migliorelli on 21/06/23.
//

import SwiftUI

struct MenuBar: Scene {
	@Environment(\.openWindow) private var openWindow
	@StateObject private var clockModel: ClockModel = ClockModel.shared
	@StateObject private var relaxModel: RelaxModel = RelaxModel(ClockModel.shared.relaxingTime)
	
	var body: some Scene {
		MenuBarExtra(
			content: {
				if clockModel.relaxingTime == 0 {
					if clockModel.isPaused {
						Button(action: clockModel.start) {
							Image(systemName: "play.fill")
							Text("Start")
						}
					} else {
						Button(action: clockModel.endSession) {
							Image(systemName: "cup.and.saucer.fill")
							Text("Riposati per \(clockModel.relaxDuration.minuteSecond)")
						}
					}
					
					Button(action: clockModel.reset) {
						Image(systemName: "gobackward")
						Text("Reset")
					}
					
					Divider()
				}
				Text("Totale ~ \(clockModel.actualTotal.minuteSecond)")
				Text("Record ~ \(clockModel.actualRecord.minuteSecond)")
				
				Divider()
				
				Button("Open View"){
					NSApplication.shared.activate(ignoringOtherApps: true)
					openWindow(id: "MainScreen")
				}.keyboardShortcut("n")
				
				Button("Quit"){
					NSApplication.shared.terminate(nil)
				}.keyboardShortcut("q")
					.onAppear { clockModel.relaxingTime = 0 }
			}, label: {
				if clockModel.relaxingTime == 0 {
					Image(systemName: "timer")
					if !clockModel.isPaused{
						Text(clockModel.duration.minuteSecond)
					}
				} else {
					Image(systemName: "cup.and.saucer.fill")
					Text(relaxModel.duration.minuteSecond)
						.onAppear(perform: relaxModel.start)
				}
			}
		)
	}
}
