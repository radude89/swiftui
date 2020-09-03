//
//  UserC+CoreDataProperties.swift
//  FriendFace
//
//  Created by Radu Dan on 03/09/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//
//

import Foundation
import CoreData


extension UserC {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserC> {
        return NSFetchRequest<UserC>(entityName: "UserC")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var email: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: NSSet?
    @NSManaged public var friends: NSSet?
    
    public var wrappedID: UUID {
        id ?? UUID()
    }
    
    public var wrappedName: String {
        name ?? "Unknown name"
    }
    
    public var wrappedAbout: String {
        about ?? "Unknown"
    }
    
    public var wrappedAddress: String {
        address ?? "Unknown"
    }
    
    public var wrappedEmail: String {
        email ?? "Unknown"
    }
    
    public var wrappedCompany: String {
        company ?? "Unknown"
    }
    
    public var tagsArray: [TagC] {
        let set = tags as? Set<TagC> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    
    public var friendsArray: [FriendC] {
        let set = friends as? Set<FriendC> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    
    public var formattedRegisteredDate: String? {
        guard let registered = registered else { return nil}

        return User.dateFormatter.string(from: registered)
    }

}

// MARK: Generated accessors for tags
extension UserC {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: TagC)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: TagC)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}

// MARK: Generated accessors for friends
extension UserC {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: FriendC)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: FriendC)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

// MARK: - Server Model
extension UserC {
    convenience init(context: NSManagedObjectContext, user: User) {
        self.init(context: context)
        
        id = user.id
        name = user.name
        about = user.about
        address = user.address
        age = Int16(user.age)
        email = user.email
        company = user.company
        registered = user.registered
        isActive = user.isActive
        
        let tags: [TagC] = user.tags.map { tagName in
            let tag = TagC(context: context)
            tag.name = tagName
            return tag
        }
        tags.forEach { addToTags($0) }
        
        let friends: [FriendC] = user.friends.map {
            let friend = FriendC(context: context)
            friend.name = $0.name
            friend.id = $0.id
            return friend
        }
        friends.forEach { addToFriends($0) }
    }
}
