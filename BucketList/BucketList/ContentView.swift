//
//  ContentView.swift
//  BucketList
//
//  Created by Radu Dan on 19/10/2020.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations: [MKPointAnnotation] = []
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    
    var body: some View {
        ZStack {
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
                        let newLocation = MKPointAnnotation()
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
            .sheet(isPresented: $showingEditScreen) {
                if let selectedPlace = selectedPlace {
                    EditView(placemark: selectedPlace)
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
