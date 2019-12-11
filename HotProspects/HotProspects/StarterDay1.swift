//
//  StarterDay1.swift
//  HotProspects
//
//  Created by Németh Gergely on 2019. 12. 11..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
    @EnvironmentObject var user: User

    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User

    var body: some View {
        Text(user.name)
    }
}

struct StarterDay1_1: View {
    let user = User()

    var body: some View {
        VStack {
            EditView()
            DisplayView()
        }
        .environmentObject(user)
    }
}

struct StarterDay1_2: View {
    @State private var selectedTab = "tab1"

    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab 1")
                .onTapGesture {
                    self.selectedTab = "tab2"
            }
            .tabItem {
                Image(systemName: "star")
                Text("One")
            }
            .tag("tab1")

            Text("Tab 2")
                .onTapGesture {
                        self.selectedTab = "tab1"
                }
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Two")
            }
            .tag("tab2")
        }
    }
}

struct StarterDay1_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StarterDay1_1()
            StarterDay1_2()
        }
    }
}
