//
//  RolledEntry.swift
//  RollDice
//
//  Created by Radu Dan on 28.11.2020.
//

import Foundation

struct RolledEntry: Identifiable, Codable {
    var id = UUID()
    var timestamp = Date()
    let entries: [Int]
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .medium
        return dateFormatter.string(from: timestamp)
    }
}

final class RolledEntries: ObservableObject {
    @Published private(set) var rolls: [RolledEntry]
    private static let saveKey = "SavedEntries"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: Self.saveKey),
           let rolls = try? JSONDecoder().decode([RolledEntry].self, from: data) {
            self.rolls = rolls
            return
        }
        
        rolls = []
    }
    
    func add(_ rolledEntry: RolledEntry) {
        rolls.append(rolledEntry)
        save()
    }
    
    private func save() {
        if let rolledEntries = try? JSONEncoder().encode(rolls) {
            UserDefaults.standard.setValue(rolledEntries, forKey: Self.saveKey)
        }
    }
}
