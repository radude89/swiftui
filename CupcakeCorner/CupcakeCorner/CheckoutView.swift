//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Radu Dan on 07/08/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var checkoutSummary: CheckoutSummary
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingMessage = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is: $\(checkoutSummary.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place order") {
                        placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingMessage) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(checkoutSummary) else {
            print("Failed to encode order.")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                showAlert(
                    title: "Error",
                    message: "No data in response.\nError description: \(error?.localizedDescription ?? "Unknown error")."
                )
                return
            }
            
            if let decodedSummary = try? JSONDecoder().decode(CheckoutSummary.self, from: data) {
                showAlert(
                    title: "Thank you!",
                    message: "Your order for \(decodedSummary.order.quantity) x \(Order.types[decodedSummary.order.type].lowercased()) cupcakes is on its way!"
                )
            } else {
                showAlert(
                    title: "Error",
                    message: "Something went wrong. Please retry your order."
                )
            }
            
        }.resume()
    }
    
    private func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showingMessage = true
    }
    
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(checkoutSummary: CheckoutSummary())
    }
}
