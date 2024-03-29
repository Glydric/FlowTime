//
//  FlowTimeApp.swift
//  testnewproject
//
//  Created by Leonardo Migliorelli on 10/04/23.
//

import SwiftUI

@main
struct FlowTimeApp: App {
	@NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
	@StateObject private var viewModel: ClockModel = ClockModel.shared
	
	var body: some Scene {
		MenuBar()
		
		WindowGroup(id: "MainScreen") {
			if viewModel.relaxingTime == 0 {
				ClockView()
			} else {
				RelaxView()
			}
		}
		
		Window("Edit Profile", id: "EditProfile") {
			EditProfile()
		}
		
		Window("Settings", id: "Settings") {
			SettingsView()
		}
		.windowResizability(.contentSize)
		
		//		Settings{
		//			SettingsView()
		//		}
		
	}
}
