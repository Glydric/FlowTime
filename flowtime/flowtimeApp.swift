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
    @State var isRelaxing = false;

    var body: some Scene {
        WindowGroup {
            if (isRelaxing) {
                RelaxView()
            } else {
                MainView(isRelaxing: $isRelaxing)
            }
        }
    }
}
