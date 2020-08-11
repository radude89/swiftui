//
//  Order.swift
//  CupcakeCorner
//
//  Created by Radu Dan on 07/08/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import Foundation

// MARK: - Order
struct Order {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
}

extension Order {
    var hasValidAddress: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
            !streetAddress.trimmingCharacters(in: .whitespaces).isEmpty &&
            !city.trimmingCharacters(in: .whitespaces).isEmpty &&
            !zip.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        cost += Double(type) / 2
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}
