//
//  ShowingAlertView.swift
//  SnowSeeker
//
//  Created by Radu Dan on 29.11.2020.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct ShowingAlertView: View {
    @State private var selectedUser: User?
    
    var body: some View {
        Text("Hello, world!")
            .onTapGesture {
                selectedUser = User()
            }
            .alert(item: $selectedUser) { user in
                Alert(title: Text(user.id))
            }
    }
}

struct ShowingAlertView_Previews: PreviewProvider {
    static var previews: some View {
        ShowingAlertView()
    }
}
