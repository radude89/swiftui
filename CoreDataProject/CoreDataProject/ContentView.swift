//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Radu Dan on 27/08/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var titleFilter = "A"
    
    var body: some View {
        VStack {
            FilteredList(
                filterKey: "title",
                filterValue: titleFilter,
                sortDescriptors: [
                    NSSortDescriptor(keyPath: \Movie.year, ascending: false),
                    NSSortDescriptor(keyPath: \Movie.title, ascending: true)
                ]
            ) { (movie: Movie) in
                Text("\(movie.title) \(movie.director) - \(Int(movie.year))")
            }
            
            VStack {
                // list of matching singers
                
                Button("Add Examples") {
                    let film1 = Movie(context: self.moc)
                    film1.title = "Pulp fiction"
                    film1.director = "Quentin Tarantino"
                    film1.year = 1999
                    
                    let film2 = Movie(context: self.moc)
                    film2.title = "Kill Bil vol. 1"
                    film2.director = "Quentin Tarantino"
                    film2.year = 2002
                    
                    let film3 = Movie(context: self.moc)
                    film3.title = "Once upon a time in Hollywood"
                    film3.director = "Quentin Tarantino"
                    film3.year = 2019
                    
                    let film4 = Movie(context: self.moc)
                    film4.title = "Kill Bil vol. 2"
                    film4.director = "Quentin Tarantino"
                    film4.year = 2003
                    
                    try? self.moc.save()
                }
                
                Button("Show P") {
                    self.titleFilter = "P"
                }
                
                Button("Show K") {
                    self.titleFilter = "K"
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
