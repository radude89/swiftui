//
//  ContentView.swift
//  SwiftUI19
//
//  Created by Radu Dan on 06/05/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private let litresConversionRatios = ["ml": 1000.0,
                                          "l": 1.0,
                                          "cup": 4.16667,
                                          "pint": 2.11337810957,
                                          "gallon": 0.264172]
    
    private var keys: [String] { litresConversionRatios.keys.sorted() }
    
    @State private var enteredAmount = ""
    @State private var convertedUnitIndex = 2
    @State private var selectedUnitIndex = 2
    
    private var convertedAmount: Double {
        guard let amountDouble = Double(enteredAmount),
            let selectedVolumeFactor = litresConversionRatios[keys[selectedUnitIndex]],
            let convertedVolumeFactor = litresConversionRatios[keys[convertedUnitIndex]] else {
                return 0
        }
        
        let enteredAmountInLitres = amountDouble / selectedVolumeFactor
        let convertedAmount = enteredAmountInLitres * convertedVolumeFactor
        
        return convertedAmount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter volume amount in (\(keys[selectedUnitIndex]))", text: $enteredAmount)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Select volume unit")) {
                    Picker("Selected unit", selection: $selectedUnitIndex) {
                        ForEach(0 ..< keys.count) {
                            Text("\(self.keys[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("In what unit you want to convert?")) {
                    Picker("Converted unit", selection: $convertedUnitIndex) {
                        ForEach(0 ..< keys.count) {
                            Text("\(self.keys[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Converted amount")) {
                    Text("\(convertedAmount, specifier: "%.4f") \(keys[convertedUnitIndex])")
                }
            }
            .navigationBarTitle("Volume converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
