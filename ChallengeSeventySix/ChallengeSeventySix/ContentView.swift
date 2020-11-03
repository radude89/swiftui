//
//  ContentView.swift
//  ChallengeSeventySix
//
//  Created by Radu Dan on 29/10/2020.
//

import SwiftUI
import MapKit

// MARK: - ContentView
struct ContentView: View {
    
    private let fileName = "saved-users"
    
    @State private var users: [User] = []
    @State private var currentImage: UIImage?
    @State private var enteredName = ""
    @State private var location: CLLocationCoordinate2D?
    
    @State private var showImagePicker = false
    @State private var showEnterNameView = false
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink(
                    destination: UserDetailView(user: user)
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
                ImagePicker(image: $currentImage, location: $location)
            }
        }
        .sheet(isPresented: $showEnterNameView, onDismiss: reloadData) {
            EnterNameView(name: $enteredName)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage))
        }
    }
}

// MARK: - Data Loading
private extension ContentView {
    func reloadData() {
        guard let image = currentImage else {
            showErrorAlert(message: "Image is nil.")
            return
        }
        
        guard !enteredName.isEmpty else {
            showErrorAlert(message: "Entered name is empty.")
            return
        }
        
        guard let location = location else {
            showErrorAlert(message: "Location is unknown.")
            return
        }
        
        let user = User(
            name: enteredName,
            image: image,
            latitude: location.latitude,
            longitude: location.longitude
        )
        users.append(user)
        
        saveData()
        
        enteredName = ""
    }
    
    func showErrorAlert(message: String) {
        alertTitle = "Error"
        alertMessage = message
        showAlert = true
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
