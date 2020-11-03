//
//  ImagePicker.swift
//  ChallengeSeventySix
//
//  Created by Radu Dan on 29/10/2020.
//

import SwiftUI
import MapKit

// MARK: - ImagePicker
struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    @Binding var location: CLLocationCoordinate2D?
    
    private let locationFetcher = LocationFetcher()
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        locationFetcher.start()
        
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
}

// MARK: - Coordinator
extension ImagePicker {
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            
            if let location = parent.locationFetcher.lastKnownLocation {
                parent.location = location
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
