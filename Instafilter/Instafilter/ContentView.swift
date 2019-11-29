//
//  ContentView.swift
//  Instafilter
//
//  Created by Gergely Németh on 2019. 11. 27..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI


struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterIntensitySecondary = 0.5
    @State private var showingFilterSheet = false
    @State private var showingImagePicker = false
    @State private var showingError = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var currentFilter: CIFilter = CIFilter.vignette()
    let context = CIContext()

    var intensity1: Binding<Double> { Binding<Double>(
        get: { self.filterIntensity },
        set: {
            self.filterIntensity = $0
            self.applyProcessing() }
        )
    }

    var intensity2: Binding<Double> { Binding<Double>(
        get: { self.filterIntensitySecondary },
        set: {
            self.filterIntensitySecondary = $0
            print($0)
            self.applyProcessing() }
        )
    }

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)

                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }

                HStack {
                    Text("Intensity")
                    Slider(value: intensity1)
                }.padding(.vertical)

                HStack {
                    Text("2nd Intensity")
                    Slider(value: intensity2)
                }.padding(.vertical)

                HStack {
                    Button("Change Filter") {
                        self.showingFilterSheet.toggle()
                    }

                    Spacer()

                    Button("Save") {
                        let imageSaver = ImageSaver()
                        imageSaver.succesHandler = {
                            print("Success")
                        }
                        imageSaver.errorHandler = {
                            print("Ooops \($0?.localizedDescription ?? "")")
                        }
                        if let image = self.processedImage {
                            imageSaver.writeToPhotoAlbum(image: image)
                        } else {
                            self.showingError = true
                        }
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .alert(isPresented: $showingError) {
                Alert(title: Text("No image to save"), message: Text("Please select an image first!"), dismissButton: .default(Text("Ok")))
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Select a filter"), message: Text(currentFilter.description), buttons: [
                    .default(Text("Crystallize")) { self.setFilter(CIFilter.crystallize()) },
                    .default(Text("Edges")) { self.setFilter(CIFilter.edges()) },
                    .default(Text("GaussianBlur")) { self.setFilter(CIFilter.gaussianBlur()) },
                    .default(Text("Pixellate")) { self.setFilter(CIFilter.pixellate()) },
                    .default(Text("Sepia Tone")) { self.setFilter(CIFilter.sepiaTone()) },
                    .default(Text("Unsharp Mask")) { self.setFilter(CIFilter.unsharpMask()) },
                    .default(Text("Vignette")) { self.setFilter(CIFilter.vignette()) },
                    .cancel()
                ])
            }
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }

        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    func applyProcessing() {
        if currentFilter.inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if currentFilter.inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensitySecondary * 20, forKey: kCIInputRadiusKey) }
        if currentFilter.inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }

        guard let outputImage = currentFilter.outputImage else { return }

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }

    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
