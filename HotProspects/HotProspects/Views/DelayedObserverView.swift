//
//  DelayedObserverView.swift
//  HotProspects
//
//  Created by Radu Dan on 10/11/2020.
//

import SwiftUI

final class DelayedUpdater: ObservableObject {
    @Published var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
    
}

struct DelayedObserverView: View {
    @ObservedObject var updater = DelayedUpdater()
    
    var body: some View {
        Text("Value is \(updater.value)")
    }
}

struct DelayedObserverView_Previews: PreviewProvider {
    static var previews: some View {
        DelayedObserverView()
    }
}
