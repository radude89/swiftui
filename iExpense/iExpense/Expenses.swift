//
//  Expenses.swift
//  iExpense
//
//  Created by Radu Dan on 22/07/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}

final class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }
    
    init() {
        if let itemsAsData = UserDefaults.standard.data(forKey: "items") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([ExpenseItem].self, from: itemsAsData) {
                self.items = decoded
                return
            }
        }
        
        items = []
    }
}
