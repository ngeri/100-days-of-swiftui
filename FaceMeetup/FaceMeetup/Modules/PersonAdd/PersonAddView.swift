import SwiftUI

struct PersonAddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: PersonAddViewModel
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var name: String = ""
    @State private var showingImagePicker = false

    var body: some View {
        NavigationView {
            contentView
                .navigationBarTitle(viewModel.navigationBarTitle)
                .navigationBarItems(trailing: Button(action: {
                    self.viewModel.addPerson(with: self.name, image: self.inputImage ?? UIImage())
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                })
                .sheet(isPresented: $showingImagePicker, onDismiss: imageChosen) {
                    ImagePicker(image: self.$inputImage)
                }
        }
    }

    private var contentView: some View {
        VStack {
            TextField("Name", text: $name)
                .padding()
            ZStack {
                Rectangle()
                    .fill(Color.secondary)
                    .aspectRatio(1, contentMode: .fit)

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
            Spacer()
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
    func addPerson(with name: String, image: UIImage) {
    }
}
