//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Radu Dan on 20/10/2020.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    var wrappedTitle: String {
        get {
            title ?? "Unknown value"
        }
        set {
            title = newValue
        }
    }
    
    var wrappedSubtitle: String {
        get {
            subtitle ?? "Unknown value"
        }
        set {
            subtitle = newValue
        }
    }
}
