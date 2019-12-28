//
//  TechniquesDay1.swift
//  SnowSeeker
//
//  Created by Németh Gergely on 2019. 12. 28..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

struct TechniquesDay1: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: Text("New secondary")) {
                Text("Hello, World!")
            }
            .navigationBarTitle("Primary")

            Text("Secondary")
        }
    }
}

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct TechniquesDay1_2: View {
    @State private var selectedUser: User? = nil

    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                self.selectedUser = User()
            }
            .alert(item: $selectedUser) { user in
                Alert(title: Text(user.id))
            }
    }
}

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna, Arya, and Toby")
        }
    }
}

struct TechniquesDay1_3: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        Group {
            if sizeClass == .compact {
                VStack(content: UserView.init)
            } else {
                HStack(content: UserView.init)
            }
        }
    }
}

struct TechniquesDay1_Previews: PreviewProvider {
    static var previews: some View {
        TechniquesDay1_3()
    }
}
