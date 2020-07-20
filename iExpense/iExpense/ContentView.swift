//
//  ContentView.swift
//  iExpense
//
//  Created by Radu Dan on 20/07/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct ContentView: View {
    @ObservedObject var user = User()
    
    var body: some View {
        VStack {
            Text("Hello, \(user.firstName) \(user.lastName)!")
            TextField("Your first name:", text: $user.firstName)
            TextField("Your last name:", text: $user.lastName)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
