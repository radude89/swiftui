//
//  ContentView.swift
//  InstaFilter
//
//  Created by Radu Dan on 15/10/2020.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 100.0
    @State private var filterScale = 5.0
    
    @State private var showingFilterSheet = false
    @State private var showingImagePicker = false
    @State private var showingAlert = false
    
    @State private var changeFilterButtonTitle = "Change filter"
    
    private let context = CIContext()
    
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                filterIntensity
            },
            set: {
                filterIntensity = $0
                applyProcessing()
            }
        )
        
        let radius = Binding<Double>(
            get: {
                filterRadius
            },
            set: {
                filterRadius = $0
                applyProcessing()
            }
        )
        
        let scale = Binding<Double>(
            get: {
                filterScale
            },
            set: {
                filterScale = $0
                applyProcessing()
            }
        )
        
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if let image = image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                
                VStack(spacing: 10) {
                    HStack {
                        Text("Intensity")
                        Slider(
                            value: intensity,
                            in: 0...1,
                            step: 0.1
                        )
                    }
                    .padding(.vertical)
                    
                    HStack {
                        Text("Radius")
                        Slider(
                            value: radius,
                            in: 10...150,
                            step: 15
                        )
                    }
                    .padding(.vertical)
                    
                    HStack {
                        Text("Scale")
                        Slider(
                            value: scale,
                            in: 1...5,
                            step: 1
                        )
                    }
                    .padding(.vertical)
                }
                
                HStack {
                    Button(changeFilterButtonTitle) {
                        showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        guard let processedImage = processedImage else {
                            showingAlert = true
                            return
                        }
                        
                        let imageSaver = ImageSaver()
                        imageSaver.successHandler = {
                            print("Success")
                        }
                        imageSaver.errorHandler = {
                            print("Ooops \($0.localizedDescription)")
                        }
                        
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("Make sure you select an image"),
                    dismissButton: .default(Text("OK"))
                )
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(
                    title: Text("Select a filter"),
                    buttons: [
                        .default(Text("Crystallize")) {
                            setFilter(.crystallize())
                        },
                        .default(Text("Edges")) {
                            setFilter(.edges())
                        },
                        .default(Text("Gaussian Blur")) {
                            setFilter(.gaussianBlur())
                        },
                        .default(Text("Pixellate")) {
                            setFilter(.pixellate())
                        },
                        .cancel()
                    ]
                )
            }
        }
    }
    
    private func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        
        let initialImage = CIImage(image: inputImage)
        currentFilter.setValue(initialImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    private func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else {
            return
        }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    private func setFilter(_ filter: CIFilter) {
        let filterName = filter.name.dropFirst(2).capitalized
        changeFilterButtonTitle = filterName
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
