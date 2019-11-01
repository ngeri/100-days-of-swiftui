//
//  ContentView.swift
//  Moonshot
//
//  Created by Németh Gergely on 2019. 11. 01..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            GeometryReader { geo in
//                Image("image")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: geo.size.width)
//            }
//        }
//    }
//}

//struct CustomText: View {
//    var text: String
//
//    var body: some View {
//        Text(text)
//    }
//
//    init(_ text: String) {
//        print("Createing a CustomText")
//        self.text = text
//    }
//}
//
//struct ContentView: View {
//    var body: some View {
////        ScrollView {
////            VStack(spacing: 10) {
////                ForEach(0..<100) {
////                    CustomText("Item \($0)")
////                        .font(.title)
////                }
////            }
////            .frame(maxWidth: .infinity)
////        }
//        List {
//            ForEach(0..<100) {
//                CustomText("Item \($0)")
//                    .font(.title)
//            }
//        }
//    }
//}

//struct ContentView: View {
//    var body: some View {
//        NavigationView {
//            List(0..<100) { row in
//                NavigationLink(destination: Text("Detail \(row)")) {
//                    Text("Row \(row)")
//                }
//            }
//            .navigationBarTitle("SwiftUI")
//        }
//    }
//}

//struct ContentView: View {
//    var body: some View {
//        Button("Decode JSON") {
//            let input = """
//            {
//                "name": "Taylor Swift",
//                "address": {
//                    "street": "555, Taylor Swift Avenue",
//                    "city": "Nashville"
//                }
//            }
//            """
//
//            struct User: Codable {
//                var name: String
//                var address: Address
//            }
//
//            struct Address: Codable {
//                var street: String
//                var city: String
//            }
//
//            let data = Data(input.utf8)
//            let decoder = JSONDecoder()
//            if let user = try? decoder.decode(User.self, from: data) {
//                print(user.address.street)
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
