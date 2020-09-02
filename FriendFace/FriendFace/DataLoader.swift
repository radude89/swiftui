//
//  DataLoader.swift
//  FriendFace
//
//  Created by Radu Dan on 01/09/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import Foundation

struct DataLoader {
    func fetchData(completion: @escaping ([User]) -> Void) {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                print(error?.localizedDescription ?? "Unknown error")
                completion([])
                return
            }
            
            guard let data = data, data.isEmpty == false else {
                print("Response data is empty")
                completion([])
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let users = try decoder.decode([User].self, from: data)
                completion(users)
            } catch {
                print(error.localizedDescription)
                completion([])
            }
            
        }.resume()
    }
}
