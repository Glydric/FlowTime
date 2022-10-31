//
//  ContentView.swift
//  flowtime
//
//  Created by Leonardo Migliorelli on 31/10/22.
//
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var watch = StopWatch();

    var body: some View {
        VStack {
            Button("Start", action: start)
            Button("Stop", action: stop)
            Text(String(watch.duration))
        }
        .padding()
    }

    func stop(){
        watch.updateDuration();
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
