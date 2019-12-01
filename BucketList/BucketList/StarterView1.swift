//
//  StarterView1.swift
//  BucketList
//
//  Created by Németh Gergely on 2019. 12. 01..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String

    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct ContentView1: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ].sorted()

    var body: some View {
        List(users) { user in
            Text("\(user.lastName), \(user.firstName)")
        }
    }
}

struct ContentView2: View {
    var body: some View {
        Text("Hello World")
            .onTapGesture {
                let str = "Test Message"
                do {
                    let url = try FileManager.write(string: str, file: "message.txt")
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
        }
    }
}

enum LoadingState {
    case loading, success, failed
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct ContentView3: View {
    var loadingState = LoadingState.success

    var body: some View {
        Group {
            if loadingState == .loading {
                LoadingView()
            } else if loadingState == .success {
                SuccessView()
            } else if loadingState == .failed {
                FailedView()
            }
        }
    }
}

extension FileManager {
    static var documentsDirectory: URL {
        `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    @discardableResult static func write(string: String, file fileName: String) throws -> URL {
        let url = documentsDirectory.appendingPathComponent(fileName)
        try string.write(to: url, atomically: true, encoding: .utf8)
        return url
    }
}

struct StarterView1_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView3()
            ContentView1()
            ContentView2()
        }
    }
}

