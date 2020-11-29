//
//  Resort.swift
//  SnowSeeker
//
//  Created by Radu Dan on 29.11.2020.
//

import Foundation

struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
}

extension Resort: Comparable {
    static func < (lhs: Resort, rhs: Resort) -> Bool {
        (lhs.name, lhs.country) < (rhs.name, rhs.country)
    }
    
    static func == (lhs: Resort, rhs: Resort) -> Bool {
        lhs.id == rhs.id
    }
}

extension Resort {
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
}
