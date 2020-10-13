//
//  TaylorSwiftView.swift
//  CupcakeCorner
//
//  Created by Radu Dan on 06/08/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct TaylorSwiftView: View {
    @State private var results: [Result] = []
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data,
                let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                
                DispatchQueue.main.async {
                    results = decodedResponse.results
                }
                
                return
            }
            
            print("Fetch failed \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct TaylorSwiftView_Previews: PreviewProvider {
    static var previews: some View {
        TaylorSwiftView()
    }
}
