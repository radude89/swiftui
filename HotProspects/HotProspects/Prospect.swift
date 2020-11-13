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
    @Published var people: [Prospect]
    
    init() {
        people = []
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
    }
}
