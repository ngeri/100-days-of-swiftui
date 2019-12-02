//
//  StarterView2.swift
//  BucketList
//
//  Created by Németh Gergely on 2019. 12. 01..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import LocalAuthentication
import MapKit
import SwiftUI

struct StarterView2: View {
    var body: some View {
        MapView(centerCoordinate: .constant(MKPointAnnotation.example.coordinate), selectedPlace: .constant(MKPointAnnotation.example), showingPlaceDetails: .constant(false), annotations: [MKPointAnnotation.example])
            .edgesIgnoringSafeArea(.all)
    }
}

struct StarterView2_2: View {
    @State private var isUnlocked = false

    var body: some View {
        VStack {
            if self.isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }

    func authenticate() {
        let context = LAContext()

        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        print("\(error)")
                    }
                }
            }
        } else {
            // no biometrics
        }
    }
}

struct StarterView2_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StarterView2_2()
            StarterView2()
        }
    }
}
