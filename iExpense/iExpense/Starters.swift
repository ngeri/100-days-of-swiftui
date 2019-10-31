//
//  ContentView.swift
//  iExpense
//
//  Created by Németh Gergely on 2019. 10. 31..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

/// Why @State only works with structs

//struct User {
//    var firstname = "Bilbo"
//    var lastName = "Baggins"
//}
//
//struct ContentView: View {
//    @State private var user = User()
//
//    var body: some View {
//        VStack {
//            Text("Your name is \(user.firstname) \(user.lastName)")
//            TextField("First name", text: $user.firstname)
//            TextField("Last name", text: $user.lastName)
//        }
//    }
//}

/// Sharing SwiftUI state with @ObservedObject
/// @Published + @ObservedObject = @State

//class User: ObservableObject {
//    @Published var firstname = "Bilbo"
//    @Published var lastName = "Baggins"
//}
//
//struct ContentView: View {
//    @ObservedObject private var user = User()
//
//    var body: some View {
//        VStack {
//            Text("Your name is \(user.firstname) \(user.lastName)")
//            TextField("First name", text: $user.firstname)
//            TextField("Last name", text: $user.lastName)
//        }
//    }
//}

/// Showing and hiding views

//struct SecondView: View {
//    @Environment(\.presentationMode) var presentationMode
//    var name: String
//
//    var body: some View {
//        VStack {
//            Text("Hello \(name)!")
//            Button(action: {
//                self.presentationMode.wrappedValue.dismiss()
//            }) {
//                Text("Dismiss")
//            }
//        }
//    }
//}
//
//struct ContentView: View {
//    @State private var showingSheet = false
//
//    var body: some View {
//        Button(action: {
//            self.showingSheet.toggle()
//        }) {
//            Text("Show Sheet")
//        }
//        .sheet(isPresented: $showingSheet) {
//            SecondView(name: "@twostraws")
//        }
//    }
//}

/// Deleting items using onDelete()

//struct ContentView: View {
//    @State private var numbers = [Int]()
//    @State private var currentNumber = 1
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                List {
//                    ForEach(numbers, id: \.self) {
//                        Text("\($0)")
//                    }
//                    .onDelete(perform: removeRows)
//                }
//
//                Button("Add number") {
//                    self.numbers.append(self.currentNumber)
//                    self.currentNumber += 1
//                }
//            }
//            .navigationBarItems(leading: EditButton())
//        }
//
//    }
//
//    func removeRows(at offsets: IndexSet) {
//        numbers.remove(atOffsets: offsets)
//    }
//}

/// Storing user settings with UserDefaults

//struct ContentView: View {
//    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
//
//    var body: some View {
//        Button("Tap coun: \(tapCount)") {
//            self.tapCount += 1
//            UserDefaults.standard.set(self.tapCount, forKey: "Tap")
//        }
//    }
//}

/// Archiving Swift objects with Codable

//struct User: Codable {
//    var firstName: String
//    var lastName: String
//}
//
//struct ContentView: View {
//    @State private var user = User(firstName: "Taylor", lastName: "Swift")
//
//    var body: some View {
//        Button("Save User") {
//            let encoder = JSONEncoder()
//
//            if let data = try? encoder.encode(self.user) {
//                UserDefaults.standard.set(data, forKey: "UserData")
//            }
//
//        }
//    }
//}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
