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
	
	@AppStorage("settings.showTimer") private var showTimer = true
	
	@State var alert = 25
	
	private var profiles: [Profile] { clockModel.profiles }
	private var actual: Profile { clockModel.actualProfile }
	private var others: [Profile] { profiles.filter { $0 != actual } }
	
	
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
							Text("Relax for \(clockModel.relaxDuration.minuteSecond)")
						}
					}
					
					if(!clockModel.isPaused){
						Button(action: clockModel.reset) {
							Image(systemName: "trash.fill")
							Text("Cancel")
						}
					}
					
					Button("Open View"){
						NSApplication.shared.activate(ignoringOtherApps: true)
						openWindow(id: "MainScreen")
					}.keyboardShortcut("n")
					
					Divider()
				}
				
				if profiles.count == 1 {
					Button(actual.title) {}
				} else {
					Menu("Profile \(actual.title)") {
						ForEach(others, id: \.self) { p in
							Button(p.title) {
								StorageManager.actualProfile = p
							}
						}
					}
				}
				
				Text("Total ~ \(clockModel.actualTotal.minuteSecond)")
					
				Text("Record ~ \(clockModel.actualRecord.minuteSecond)")
				
				Button(action: openEditProfile, label: {
					Image(systemName: "pencil")
					Text("Edit Profiles")
				})
				
				Divider()
				
				
				Button(action: {
					NSApplication.shared.activate(ignoringOtherApps: true)
					openWindow(id: "Settings")
				}, label: {
					Text("Preferences...")
				})
				.keyboardShortcut(",")
				
				Button("Quit"){
					NSApplication.shared.terminate(nil)
				}.keyboardShortcut("q")
					.onAppear { clockModel.relaxingTime = 0 }
			}, label: {
				if clockModel.relaxingTime == 0 {
					Image(systemName: "timer", withHierarchicalColor: actual.color.nsColor)
					
					Text(clockModel.duration.minuteSecond)
						.hidden(!showTimer)
						.hidden(clockModel.isPaused)
				} else {
					Image(systemName: "cup.and.saucer.fill", withHierarchicalColor: actual.color.nsColor)
					Text(relaxModel.duration.minuteSecond)
						.onAppear(perform: relaxModel.start)
				}
			}
		)
	}
	
	func openEditProfile() {
		NSApplication.shared.activate(ignoringOtherApps: true)
		openWindow(id: "EditProfile")
	}
}

