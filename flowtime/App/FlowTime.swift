//
//  FlowTimeApp.swift
//  testnewproject
//
//  Created by Leonardo Migliorelli on 10/04/23.
//

import SwiftUI

@main
struct FlowTimeApp: App {
	@State var relaxingTime: TimeInterval = 0
	
	var body: some Scene {
		WindowGroup {
			if relaxingTime == 0 {
				ClockView(relaxingTime: $relaxingTime)
			} else {
				RelaxView(relaxingTime: $relaxingTime)
			}
		}
	}
}
