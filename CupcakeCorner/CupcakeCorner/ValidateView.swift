//
//  ValidateView.swift
//  CupcakeCorner
//
//  Created by Radu Dan on 06/08/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct ValidateView: View {
    @State private var username = ""
    @State private var email = ""
    
    private var disabledForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create account") {
                    print("Creating account…")
                }
            }
            .disabled(disabledForm)
        }
    }
}

struct ValidateView_Previews: PreviewProvider {
    static var previews: some View {
        ValidateView()
    }
}
