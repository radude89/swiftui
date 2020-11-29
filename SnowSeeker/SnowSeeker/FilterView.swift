//
//  FilterView.swift
//  SnowSeeker
//
//  Created by Radu Dan on 29.11.2020.
//

import SwiftUI

final class Filters: ObservableObject {
    @Published var selectedCountry = "All"
    @Published var selectedCountryIndex = 0
    
    @Published var selectedSize = "All"
    @Published var selectedSizeIndex = 0
    
    @Published var selectedPrice = "All"
    @Published var selectedPriceIndex = 0
    
    var selectedSizeAsInt: Int {
        switch selectedSize {
        case "Small":
            return 1
            
        case "Average":
            return 2
            
        default:
            return 3
        }
    }
    
    var priceAsInt: Int {
        switch selectedPrice {
        case "$":
            return 1
            
        case "$$":
            return 2
            
        default:
            return 3
        }
    }
}

struct FilterView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var filters: Filters
    
    let countries: Set<String>
        
    private var countryOptions: [String] {
        var allCountries = Array(countries)
        allCountries.sort()
        allCountries.insert("All", at: 0)
        return allCountries
    }
    
    private let sizes = ["All", "Small", "Average", "Large"]
    private let prices = ["All", "$", "$$", "$$$"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Country")) {
                    Picker(selection: $filters.selectedCountryIndex, label: Text("Selected country")) {
                        ForEach(0 ..< countryOptions.count) {
                            Text(countryOptions[$0])
                        }
                    }
                }
                
                Section(header: Text("Size")) {
                    Picker(selection: $filters.selectedSizeIndex, label: Text("Select size")) {
                        ForEach(0 ..< sizes.count) {
                            Text(sizes[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Price")) {
                    Picker(selection: $filters.selectedPriceIndex, label: Text("Select price")) {
                        ForEach(0 ..< prices.count) {
                            Text(prices[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Filter")
            .navigationBarItems(
                trailing:
                    Button("Done") {
                        filters.selectedCountry = Array(countryOptions)[filters.selectedCountryIndex]
                        filters.selectedSize = sizes[filters.selectedSizeIndex]
                        filters.selectedPrice = prices[filters.selectedPriceIndex]
                        presentationMode.wrappedValue.dismiss()
                    }
            )
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(countries: ["Test"])
    }
}
