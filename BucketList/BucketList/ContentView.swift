//
//  ContentView.swift
//  BucketList
//
//  Created by Németh Gergely on 2019. 11. 30..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import LocalAuthentication
import MapKit
import SwiftUI

struct TargetView: View {
    var body: some View {
        Circle()
            .fill(Color.blue)
            .opacity(0.3)
            .frame(width: 32, height: 32)
    }
}

struct AddNewLocationButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: {
            self.action()
        }) {
            Image(systemName: "plus")
                .padding()
                .background(Color.black.opacity(0.75))
                .foregroundColor(.white)
                .font(.title)
                .clipShape(Circle())
        }
        .padding(.trailing)
    }
}

struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingBiometricAuthenticationError = false
    @State private var showingEditScreen = false
    @State private var isUnlocked = false

    @State private var alertTitle = ""
    @State private var alertMessage = ""

    func alert(for selectedPlace: MKPointAnnotation?) -> Alert {
        Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information."), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
            self.showingEditScreen = true
        })
    }

    func alert() -> Alert {
        Alert(title: Text("Fucnk  you"), message: Text( "Missing place information."), dismissButton: .default(Text("OK")))
    }

    var body: some View {
        let customBinding = Binding(
            get: {
                return self.showingPlaceDetails || self.showingBiometricAuthenticationError
            },
            set: {
                if !$0 {
                    self.showingPlaceDetails = $0
                    self.showingBiometricAuthenticationError = $0
                }
            }
        )

        return ZStack {
            if isUnlocked {
                MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations)
                    .edgesIgnoringSafeArea(.all)
                TargetView()
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        AddNewLocationButton {
                            let newLocation = CodableMKPointAnnotation()
                            newLocation.title = "Example Location"
                            newLocation.coordinate = self.centerCoordinate
                            self.locations.append(newLocation)
                            self.selectedPlace = newLocation
                            self.showingEditScreen = true
                        }
                    }
                }
            } else {
                Button("Unlock Places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        .alert(isPresented: customBinding) {
            if self.showingPlaceDetails {
                return self.alert(for: self.selectedPlace)
            } else {
                return self.alert()
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        }
        .onAppear(perform: loadData)
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")

        do {
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }

    func saveData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.showingBiometricAuthenticationError = true
                    }
                }
            }
        } else {
            // no biometrics
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
