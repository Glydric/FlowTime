//
//  flowtimeApp.swift
//  flowtime
//
//  Created by Leonardo Migliorelli on 31/10/22.
//

import SwiftUI

@main
struct flowtimeApp: App {
    @State var relaxingTime: TimeInterval = 0
    @State var total: TimeInterval = 0
    @State var record: TimeInterval = 0

    var body: some Scene {
        WindowGroup {
            actualView
        }
    }

    var actualView: some View {
        if relaxingTime != 0 {
            return AnyView(RelaxView(time: $relaxingTime))
        }
        return AnyView(
                MainView(
                        relaxingTime: $relaxingTime,
                        oldTotal: $total,
                        oldRecord: $record
                )
        )
    }

}
