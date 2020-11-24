//
//  SettingsView.swift
//  Flashzilla
//
//  Created by Radu Dan on 24.11.2020.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var cardBackToDeck: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General")) {
                    Toggle(isOn: $cardBackToDeck) {
                        Text("When you get an answer one wrong that card goes back into the array so the user can try it again")
                    }
                }
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button("Done", action: dismiss))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(cardBackToDeck: .constant(true))
    }
}
