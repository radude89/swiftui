//
//  User.swift
//  ChallengeSeventySix
//
//  Created by Radu Dan on 30/10/2020.
//

import SwiftUI

// MARK: - User
struct User: Identifiable {
    var id = UUID()
    let name: String
    var image: Image?
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = Image(uiImage: image)
        saveImage(image)
    }
}

// MARK: - Decodable
extension User: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageName
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(UUID.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        image = loadImage()
    }
}

// MARK: - Encodable
extension User: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
}

// MARK: - Image Methods
private extension User {
    var imageName: String {
        "image_\(id.uuidString)"
    }
    
    func loadImage() -> Image? {
        do {
            let data = try FileManager.readData(fileName: imageName)
            if let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            }
        } catch {
            print("Unable to load data, error: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    func saveImage(_ image: UIImage) {
        let imageSaver = ImageSaver()
        imageSaver.successHandler = {
            print("Success")
        }
        imageSaver.errorHandler = {
            print("Ooops \($0.localizedDescription)")
        }
        
        imageSaver.saveImage(image, fileName: imageName)
    }
}
