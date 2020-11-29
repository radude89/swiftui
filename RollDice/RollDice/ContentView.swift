//
//  ContentView.swift
//  RollDice
//
//  Created by Radu Dan on 28.11.2020.
//

import SwiftUI

struct ContentView: View {
    private var rolledEntries = RolledEntries()
    private var settings = UserSettings()
    
    var body: some View {
        TabView {
            RollDiceView()
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Roll")
                }
            
            HistoryView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("History")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .environmentObject(settings)
        .environmentObject(rolledEntries)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
