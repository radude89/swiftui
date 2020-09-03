//
//  FriendC+CoreDataProperties.swift
//  FriendFace
//
//  Created by Radu Dan on 03/09/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//
//

import Foundation
import CoreData


extension FriendC {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FriendC> {
        return NSFetchRequest<FriendC>(entityName: "FriendC")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var friends: NSSet?
    
    public var wrappedID: UUID {
        id ?? UUID()
    }
    
    public var wrappedName: String {
        name ?? "Unknown name"
    }

}

// MARK: Generated accessors for friends
extension FriendC {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: UserC)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: UserC)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}
