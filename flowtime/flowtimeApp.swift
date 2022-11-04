//
//  flowtimeApp.swift
//  flowtime
//
//  Created by Leonardo Migliorelli on 31/10/22.
//
//

import SwiftUI

@main
struct flowtimeApp: App {
    @State var relaxingTime: TimeInterval = 0;
    @State var total: TimeInterval = 0;

    var body: some Scene {
        WindowGroup {
            if (relaxingTime != 0) {
                RelaxView(time: $relaxingTime)
            } else {
                MainView(relaxingTime: $relaxingTime, total: $total)
            }
        }
    }
}
