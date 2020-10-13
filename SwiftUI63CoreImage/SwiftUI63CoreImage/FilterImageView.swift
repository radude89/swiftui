//
//  FilterImageView.swift
//  SwiftUI63CoreImage
//
//  Created by Radu Dan on 13/10/2020.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct FilterImageView: View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    
    private func loadImage() {
        guard let inputImage = UIImage(named: "example") else {
            return
        }
        
        let ciImage = CIImage(image: inputImage)
        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        
        currentFilter.inputImage = ciImage
        currentFilter.intensity = 1
        
        guard let outputImage = currentFilter.outputImage else {
            return
        }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
        }
        
    }
}

struct FilterImageView_Previews: PreviewProvider {
    static var previews: some View {
        FilterImageView()
    }
}
