//
//  EnterNameView.swift
//  ChallengeSeventySix
//
//  Created by Radu Dan on 30/10/2020.
//

import SwiftUI

struct EnterNameView: View {
    @Binding var name: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TextField("Enter name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Save") {
                presentationMode.wrappedValue.dismiss()
            }.disabled(name.isEmpty)
        }
    }
}

struct EnterNameView_Previews: PreviewProvider {
    static var previews: some View {
        EnterNameView(name: .constant("John Doe"))
    }
}
