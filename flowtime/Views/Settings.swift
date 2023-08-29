//
//  Settings.swift
//  FlowTime
//
//  Created by Leonardo Migliorelli on 29/08/23.
//

import SwiftUI
import LaunchAtLogin

struct SettingsView: View {
	var body: some View {
			TabView {
				GeneralTab()
					.tabItem {
						Label("General", systemImage: "gear")
						Image(systemName: "gear")
					}
					.padding(32)
				//			OtherTab()
				//				.tabItem {
				//					Label("General", systemImage: "gear.circle")
				//				}
			}
			.padding(20)
			.frame(minWidth: 500, maxWidth: 800, maxHeight: 600)
		
	}
}

fileprivate struct GeneralTab: View {
	@AppStorage("settings.showTimer") private var showTimer = true
	
	var body: some View {
		Form {
			Toggle("Show Timer", isOn: $showTimer)
				.toggleStyle(.switch)
				.help("Shows the timer in menu bar when running")
			LaunchAtLogin
				.Toggle()
				.toggleStyle(.switch)
				.help("Launch at login")
		}
	}
}
