//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Radu Dan on 06/08/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var checkoutSummary = CheckoutSummary()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $checkoutSummary.order.type) {
                        ForEach(0..<Order.types.count, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $checkoutSummary.order.quantity, in: 3...20) {
                        Text("Number of cakes: \(checkoutSummary.order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $checkoutSummary.order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if checkoutSummary.order.specialRequestEnabled {
                        Toggle(isOn: $checkoutSummary.order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $checkoutSummary.order.addSprinkles) {
                            Text("Add sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(checkoutSummary: checkoutSummary)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
