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
	@State var total: TimeInterval = 0
	@State var record: TimeInterval = 0
	
	var body: some Scene {
		WindowGroup {
			if relaxingTime == 0 {
				MainView(
					relaxingTime: $relaxingTime,
					oldTotal: $total,
					oldRecord: $record
				)
			} else {
				RelaxView(time: $relaxingTime)
			}
		}
	}
}
