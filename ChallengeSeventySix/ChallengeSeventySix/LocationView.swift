//
//  LocationView.swift
//  ChallengeSeventySix
//
//  Created by Radu Dan on 03/11/2020.
//

import SwiftUI
import MapKit

struct LocationView: View {
    let annotation: MKPointAnnotation
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    
    var body: some View {
        UserMapView(selectedPlace: annotation)
            .edgesIgnoringSafeArea(.all)
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(annotation: MKPointAnnotation.example)
    }
}
