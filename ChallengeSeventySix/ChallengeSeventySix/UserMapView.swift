//
//  UserMapView.swift
//  ChallengeSeventySix
//
//  Created by Radu Dan on 02/11/2020.
//

import SwiftUI
import MapKit

struct UserMapView: UIViewRepresentable {
    var selectedPlace: MKPointAnnotation
        
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showAnnotations(mapView.annotations, animated: true)
        mapView.centerCoordinate = selectedPlace.coordinate
        return mapView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if uiView.annotations.count != 1 {
            uiView.removeAnnotation(selectedPlace)
            uiView.addAnnotation(selectedPlace)
        }
    }
}

extension UserMapView {
    final class Coordinator: NSObject, MKMapViewDelegate {
        var parent: UserMapView
        
        init(_ parent: UserMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Placemark"
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = nil
            }
            
            annotationView?.annotation = annotation
            
            return annotationView
        }
    }
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}

struct UserMapView_Previews: PreviewProvider {
    static var previews: some View {
        UserMapView(selectedPlace: MKPointAnnotation.example)
    }
}
