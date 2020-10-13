//
//  AddBookView.swift
//  Bookworm
//
//  Created by Radu Dan on 20/08/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    RatingView(rating: $rating)
                    
                    TextField("Write a review", text: $review)
                }
                
                Section {
                    Button("Save") {
                        saveBook()
                    }
                }.disabled(genre.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .navigationBarTitle("Add Book")
        }
    }
    
    private func saveBook() {
        let book = Book(context: moc)
        book.title = title
        book.author = author
        book.rating = Int16(rating)
        book.genre = genre
        book.review = review
        book.date = Date()
        
        try? moc.save()
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
