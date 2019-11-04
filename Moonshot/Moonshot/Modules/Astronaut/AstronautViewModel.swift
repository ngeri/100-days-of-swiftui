//
//  AstronautViewModel.swift
//  Moonshot
//
//  Created by Németh Gergely on 2019. 11. 04..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import Foundation
import Combine

final class AstronautViewModel {
    @Published var astronaut: Astronaut? = nil
    
    private let astronautService: AstronautFetchable
    
    init(astronautService: AstronautFetchable) {
        self.astronautService = astronautService
    }
}


enum AstronautFetchableError: Error {
    case notFound
}

protocol AstronautFetchable {
    func astronaut(for id: String) -> AnyPublisher<Astronaut, AstronautFetchableError>
}

struct AstronautService: AstronautFetchable {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
      self.session = session
    }
    
    func astronaut(for id: String) -> AnyPublisher<Astronaut, AstronautFetchableError> {
        let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
        
        Just(astronauts.first)
            .ma
        
        if let astronaut = astronauts.first {
            return Just(astronaut)
                .mapError { _ in
                    AstronautFetchableError.notFound
                }
                .eraseToAnyPublisher()
        } else {
            return Fail(error: AstronautFetchableError.notFound).eraseToAnyPublisher()
        }
    }
    
//    private func request<T>(with components: URLComponents) -> AnyPublisher<T, AstronautFetchableError> where T: Decodable {
//      // 1
//      guard let url = components.url else {
//        return Fail(error: AstronautFetchableError.network(description: "Couldn't create URL")).eraseToAnyPublisher()
//      }
//
//      // 2
//      return session.dataTaskPublisher(for: URLRequest(url: url))
//        // 3
//        .mapError { error in
//          .network(description: error.localizedDescription)
//        }
//        // 4
//        .flatMap(maxPublishers: .max(1)) { pair in
//          decode(pair.data)
//        }
//        // 5
//        .eraseToAnyPublisher()
//    }
}
