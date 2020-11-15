//
//  Prospect.swift
//  HotProspects
//
//  Created by Radu Dan on 12/11/2020.
//

import SwiftUI

final class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddess = ""
    fileprivate(set) var isContacted = false
}

final class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    private static let saveKey = "SavedData"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: Self.saveKey),
           let people = try? JSONDecoder().decode([Prospect].self, from: data) {
            self.people = people
            return
        }
        
        people = []
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
        
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    private func save() {
        if let encodedPeople = try? JSONEncoder().encode(people) {
            UserDefaults.standard.setValue(encodedPeople, forKey: Self.saveKey)
        }
    }
    
}
