//
//  ContentView.swift
//  flowtime
//
//  Created by Leonardo Migliorelli on 31/10/22.
//
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var watch: StopWatch = StopWatch();
    var isOn = true;

    var body: some View {
        VStack {
            Button("Start", action: start)
            Button("Stop", action: stop)
            Text("begin on \(watch.begin)")
            Text("seconds \(Int(watch.duration))")
        }
        .padding()
    }

    func stop(){
    }
    func start(){
        watch.start();
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
