//
//  TagC+CoreDataProperties.swift
//  FriendFace
//
//  Created by Radu Dan on 03/09/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//
//

import Foundation
import CoreData


extension TagC {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TagC> {
        return NSFetchRequest<TagC>(entityName: "TagC")
    }

    @NSManaged public var name: String?
    @NSManaged public var users: NSSet?
    
    public var wrappedName: String {
        name ?? "Unknown"
    }

}

// MARK: Generated accessors for users
extension TagC {

    @objc(addUsersObject:)
    @NSManaged public func addToUsers(_ value: UserC)

    @objc(removeUsersObject:)
    @NSManaged public func removeFromUsers(_ value: UserC)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: NSSet)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: NSSet)

}
