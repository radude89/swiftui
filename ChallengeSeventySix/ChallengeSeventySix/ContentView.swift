//
//  ContentView.swift
//  ChallengeSeventySix
//
//  Created by Radu Dan on 29/10/2020.
//

import SwiftUI

// MARK: - ContentView
struct ContentView: View {
    
    private let fileName = "saved-users"
    
    @State private var currentImage: UIImage?
    @State private var enteredName = ""
    @State private var users: [User] = []
    @State private var showImagePicker = false
    @State private var showEnterNameView = false
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink(
                    destination: UserView(user: user)
                ) {
                    Text("\(user.name)")
                }
            }
            .navigationBarTitle("Challenge #76")
            .navigationBarItems(trailing: Button("Add") {
                showImagePicker = true
            })
            .onAppear(perform: loadData)
            .sheet(isPresented: $showImagePicker, onDismiss: {
                showEnterNameView = true
            }) {
                ImagePicker(image: $currentImage)
            }
        }
        .sheet(isPresented: $showEnterNameView, onDismiss: reloadData) {
            EnterNameView(name: $enteredName)
        }
    }
}

// MARK: - Data Loading
private extension ContentView {
    func reloadData() {
        guard let image = currentImage else {
            print("Image is nil")
            return
        }
        
        guard !enteredName.isEmpty else {
            print("Entered name is empty")
            return
        }
        
        let user = User(name: enteredName, image: image)
        users.append(user)
        
        saveData()
        
        enteredName = ""
    }
    
    func loadData() {
        do {
            let data = try FileManager.readData(fileName: fileName)
            users = try JSONDecoder().decode([User].self, from: data)
        } catch {
            print("Unable to load data, error: \(error.localizedDescription)")
        }
    }
    
    func saveData() {
        do {
            let uri = FileManager.documentsDirectoryURL.appendingPathComponent(fileName)
            let data = try JSONEncoder().encode(users)
            try data.write(to: uri, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to load data, error: \(error.localizedDescription)")
        }
    }
}

// MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
