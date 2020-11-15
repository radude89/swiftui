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

extension Prospect: Comparable {
    static func < (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.name < rhs.name
    }
    
    static func == (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name && lhs.emailAddess == rhs.emailAddess
    }
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
