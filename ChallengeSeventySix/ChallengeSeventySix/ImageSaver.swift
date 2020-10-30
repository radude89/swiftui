//
//  ImageSaver.swift
//  ChallengeSeventySix
//
//  Created by Radu Dan on 29/10/2020.
//

import UIKit

// MARK: - ImageSaver
final class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((ImageError) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    func saveImage(_ image: UIImage,
                   compressionQuality: CGFloat = 0.8,
                   fileName: String) {
        guard let data = image.jpegData(compressionQuality: compressionQuality) else {
            errorHandler?(ImageError.generic("Unable to compress image to jpeg data."))
            return
        }
        
        do {
            try FileManager.write(data: data, fileName: fileName)
            successHandler?()
        } catch {
            errorHandler?(ImageError.generic(error.localizedDescription))
        }
    }
    
    @objc private func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(ImageError.generic(error.localizedDescription))
        } else {
            successHandler?()
        }
    }
    
}

// MARK: - Errors
enum ImageError: Error {
    case generic(String)
}
