//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Radu Dan on 27/08/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String
    @NSManaged public var director: String
    @NSManaged public var year: Int16

}
