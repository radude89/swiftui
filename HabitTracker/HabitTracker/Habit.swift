//
//  Habit.swift
//  HabitTracker
//
//  Created by Radu Dan on 04/08/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import Foundation

struct Habit: Identifiable, Codable {
    var id = UUID()
    let name: String
    let description: String
    var repetitionCount = 0
}

final class Habits: ObservableObject {
    @Published var items: [Habit] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "habits")
            }
        }
    }
    
    init() {
        if let itemsAsData = UserDefaults.standard.data(forKey: "habits") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([Habit].self, from: itemsAsData) {
                self.items = decoded
                return
            }
        }
        
        items = []
    }
}
