//
//  User.swift
//  FriendFace
//
//  Created by Radu Dan on 01/09/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    let name: String
    let isActive: Bool
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let friends: [Friend]
    let tags: [String]
    let registered: Date?
}

struct Friend: Codable, Identifiable, Hashable {
    let id: UUID
    let name: String
}

extension User {
    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }()
    
    var formattedRegisteredDate: String? {
        guard let registered = registered else { return nil}

        return Self.dateFormatter.string(from: registered)
    }
}

extension User {
    static let demoUser = User(
        id: UUID(),
        name: "John Smith",
        isActive: true,
        age: 25,
        company: "My Company",
        email: "user@email.com",
        address: "13 Joanna Street",
        about: """
    Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.\r\n
    """,
        friends: [
            Friend(id: UUID(), name: "John Smith"),
            Friend(id: UUID(), name: "Jane Smith")
        ],
        tags: ["Tag 1", "Tag 2", "Tag 3"],
        registered: Date()
    )
}
