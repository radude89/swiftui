//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Radu Dan on 29.11.2020.
//

import SwiftUI

final class Favorites: ObservableObject {
    private var resorts: Set<String>
    private static let saveKey = "Favorites"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: Self.saveKey),
           let resorts = try? JSONDecoder().decode(Set<String>.self, from: data) {
            self.resorts = resorts
            return
        }
        
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    private func save() {
        if let resorts = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.setValue(resorts, forKey: Self.saveKey)
        }
    }
    
}
