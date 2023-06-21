//
//  FlowTimeApp.swift
//  testnewproject
//
//  Created by Leonardo Migliorelli on 10/04/23.
//

import SwiftUI

@main
struct FlowTimeApp: App {
	@StateObject private var viewModel: ClockModel = ClockModel.shared
	var body: some Scene {
		MenuBar()
		
//		WindowGroup {
//			if viewModel.relaxingTime == 0 {
//				ClockView()
//			} else {
//				RelaxView()
//			}
//		}
	}
}
