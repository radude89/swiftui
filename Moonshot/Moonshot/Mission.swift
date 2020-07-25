//
//  Mission.swift
//  Moonshot
//
//  Created by Radu Dan on 24/07/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
}

extension Mission {
    var displayName: String {
        "Apollo \(id)"
    }
    
    var imageName: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        guard let launchDate = launchDate else {
            return "N/A"
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        
        return formatter.string(from: launchDate)
    }
}
