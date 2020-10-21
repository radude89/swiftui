//
//  ContentView.swift
//  BucketList
//
//  Created by Radu Dan on 19/10/2020.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations: [CodableMKPointAnnotation] = []
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    @State private var isUnlocked = false
    
    var body: some View {
        ZStack {
            if isUnlocked {
                MapView(
                    centerCoordinate: $centerCoordinate,
                    selectedPlace: $selectedPlace,
                    showingPlaceDetails: $showingPlaceDetails,
                    annotations: locations
                )
                .edgesIgnoringSafeArea(.all)
                
                Circle()
                    .fill(Color.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            let newLocation = CodableMKPointAnnotation()
                            newLocation.title = "Example Location"
                            newLocation.coordinate = centerCoordinate
                            locations.append(newLocation)
                            
                            selectedPlace = newLocation
                            showingEditScreen = true
                        }) {
                            Image(systemName: "plus")
                        }
                        .padding()
                        .background(Color.black.opacity(0.75))
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                        .padding([.bottom, .trailing])
                    }
                }
            } else {
                Button("Unlock Places") {
                    authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        .alert(isPresented: $showingPlaceDetails) {
            Alert(
                title: Text(selectedPlace?.title ?? "Unknown"),
                message: Text(selectedPlace?.subtitle ?? "Missing place information."),
                primaryButton: .default(Text("OK")),
                secondaryButton: .default(Text("Edit")) {
                    showingEditScreen = true
                }
            )
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
            if let selectedPlace = selectedPlace {
                EditView(placemark: selectedPlace)
            }
        }
        .onAppear(perform: loadData)
    }
    
    private let fileName = "saved-places"
    
    private func loadData() {
        do {
            let data = try FileManager.readData(fileName: fileName)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load data, error: \(error.localizedDescription)")
        }
    }
    
    private func saveData() {
        do {
            let uri = FileManager.documentsDirectoryURL.appendingPathComponent(fileName)
            let data = try JSONEncoder().encode(locations)
            try data.write(to: uri, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to load data, error: \(error.localizedDescription)")
        }
    }
    
    private func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            // no biometrics
            return
        }
        
        let reason = "We need to unlock your data."
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
            DispatchQueue.main.async {
                if success {
                    isUnlocked = true
                } else {
                    // error
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
