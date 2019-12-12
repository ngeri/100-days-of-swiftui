//
//  StarterDay2.swift
//  HotProspects
//
//  Created by Németh Gergely on 2019. 12. 12..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

enum NetworkError: Error {
    case badURL, requestFailed, unknown
}

struct StarterDay2_1: View {
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                self.fetchData(from: "https://www.apple.com") { result in
                    switch result {
                    case .success(let str):
                        print(str)
                    case .failure(let error):
                        switch error {
                        case .badURL:
                            print("Bad URL")
                        case .requestFailed:
                            print("Bad URL")
                        case .unknown:
                            print("Unknown error")
                        }
                    }
                }
            }
    }

    func fetchData(from urlString: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    let stringData = String(decoding: data, as: UTF8.self)
                    completion(.success(stringData))
                } else if error != nil {
                    completion(.failure(.requestFailed))
                } else {
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }
}

class DelayedUpdater: ObservableObject {
    var value = 0 {
        willSet {
            if newValue % 2 == 0 {
                objectWillChange.send()
            }
        }
    }

    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct StarterDay2_2: View {
    @ObservedObject var updater = DelayedUpdater()

    var body: some View {
        Text("Value is: \(updater.value)")
    }
}

struct StarterDay2_3: View {
    var body: some View {
        Image("example")
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
    }
}

struct StarterDay2_Previews: PreviewProvider {
    static var previews: some View {
        StarterDay2_3()
    }
}
