import MapKit
import SwiftUI

struct PersonAddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: PersonAddViewModel
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var name: String = ""
    @State private var showingImagePicker = false
    @State private var location: CLLocationCoordinate2D?
    private let locationFetcher = LocationFetcher()

    var body: some View {
        NavigationView {
            contentView
                .navigationBarTitle(viewModel.navigationBarTitle)
                .navigationBarItems(trailing: Button(action: {
                    self.viewModel.addPerson(with: self.name, image: self.inputImage ?? UIImage(), location: self.location ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                })
                .sheet(isPresented: $showingImagePicker, onDismiss: imageChosen) {
                    ImagePicker(image: self.$inputImage)
                }
                .onAppear(perform: onAppear)
        }
    }

    private func onAppear() {
        self.locationFetcher.start()
    }

    private var contentView: some View {
        VStack {
            TextField("Name", text: $name)
                .padding()
            ZStack {
                if image != nil {
                    image?
                        .resizable()
                        .scaledToFit()
                } else {
                    Rectangle()
                        .fill(Color.secondary)
                        .aspectRatio(1, contentMode: .fit)
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
            .onTapGesture {
                self.showingImagePicker = true
            }
            if location != nil {
                MapView(centerCoordinate: location!, location: MKPointAnnotation(__coordinate: location!))
            } else {
                Button(action: {
                    if let location = self.locationFetcher.lastKnownLocation {
                        self.location = location
                    } else {
                        print("Your location is unknown")
                    }
                }) {
                    Text("Read Location")
                }
                Spacer()
            }

        }
    }

    private func imageChosen() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct PersonAddView_Previews: PreviewProvider {
    static var previews: some View {
        PersonAddView(viewModel: PersonAddViewModel(personAddService: DataServiceMock()))
    }
}

extension DataServiceMock: PersonAddService {
    func addPerson(with name: String, image: UIImage, location: CLLocationCoordinate2D) {
    }
}
