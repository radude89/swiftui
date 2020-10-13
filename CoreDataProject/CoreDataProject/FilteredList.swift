//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Radu Dan on 31/08/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var result: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { result in
            content(result)
        }
    }

    init(filterKey: String,
         filterValue: String,
         predicate: Predicate = .beginsWith,
         sortDescriptors: [NSSortDescriptor] = [],
         @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(
            entity: T.entity(),
            sortDescriptors: sortDescriptors,
            predicate: NSPredicate(
                format: "%K \(predicate.rawValue) %@", filterKey, filterValue
            )
        )
        
        self.content = content
    }
}

enum Predicate: String {
    case beginsWith = "BEGINSWITH"
}
