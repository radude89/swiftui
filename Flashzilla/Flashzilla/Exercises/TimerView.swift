//
//  TimerView.swift
//  Flashzilla
//
//  Created by Radu Dan on 17.11.2020.
//

import SwiftUI

struct TimerView: View {
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    
    var body: some View {
        Text("Hello world!")
            .onReceive(timer) { time in
                print("The time is now: \(time)")
                if counter == 0 {
                    timer.upstream.connect().cancel()
                }
                counter += 1
            }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
