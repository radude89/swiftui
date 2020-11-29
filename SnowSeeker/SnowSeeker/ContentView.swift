//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Radu Dan on 29.11.2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var favorites = Favorites()
    @ObservedObject var filters = Filters()
    
    @State private var sortResorts = false
    @State private var showFilterView = false
    
    private var resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    private var sortedResorts: [Resort] {
        resorts.sorted()
    }
    
    private var filteredResorts: [Resort] {
        var resorts = sortResorts ? sortedResorts : self.resorts
        
        if filters.selectedCountry != "All" {
            resorts = resorts.filter { $0.country == filters.selectedCountry }
        }
        
        if filters.selectedSize != "All" {
            resorts = resorts.filter { $0.size == filters.selectedSizeAsInt }
        }
        
        if filters.selectedPrice != "All" {
            resorts = resorts.filter { $0.price == filters.priceAsInt }
        }
        
        return resorts
    }
    
    private var countries: Set<String> {
        if sortResorts {
            return Set(sortedResorts.map { $0.country })
        } else {
            return Set(resorts.map { $0.country })
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if favorites.contains(resort) {
                        Spacer()
                        
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                    
                }
            }
            .sheet(isPresented: $showFilterView, onDismiss: filterResorts) {
                FilterView(countries: countries)
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(
                leading:
                    Button(sortResorts ? "Unsort" : "Sort") {
                        sortResorts.toggle()
                    },
                trailing:
                    Button("Filter") {
                        showFilterView = true
                    }
            )
            
            WelcomeView()
        }
        .environmentObject(favorites)
        .environmentObject(filters)
    }
    
    private func filterResorts() {
        
    }
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
