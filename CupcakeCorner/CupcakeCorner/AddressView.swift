//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Radu Dan on 07/08/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var checkoutSummary: CheckoutSummary
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $checkoutSummary.order.name)
                TextField("Street Address", text: $checkoutSummary.order.streetAddress)
                TextField("City", text: $checkoutSummary.order.city)
                TextField("Zip", text: $checkoutSummary.order.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(checkoutSummary: checkoutSummary)) {
                    Text("Check out")
                }
            }
            .disabled(checkoutSummary.order.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(checkoutSummary: CheckoutSummary())
    }
}
