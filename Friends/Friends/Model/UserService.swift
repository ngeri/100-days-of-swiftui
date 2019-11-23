//
//  UserService.swift
//  Friends
//
//  Created by Gergely Németh on 2019. 11. 23..
//  Copyright © 2019. Gergely Németh. All rights reserved.
//

import Foundation

struct UserService {
    enum UserServiceError: Error {
        case noData
        case decoding
    }

    private let session: URLSession

    init(session: URLSession = .shared, dataService: CoreDataService = CoreDataService.shared) {
        self.session = session
    }

    func fetchUsers(completion: @escaping (Result<[User], UserServiceError>) -> Void) {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!

        session.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom { decoder in
                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
                if let date = dateFormatter.date(from: dateString) {
                    return date
                } else {
                    throw UserServiceError.decoding
                }
            }
            if let data = data {
                do {
                    let users = try decoder.decode([User].self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(users))
                    }
                } catch  {
                    DispatchQueue.main.async {
                        completion(.failure(.decoding))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
            }
        }.resume()
    }

    func fetchFriends(with ids: [String], completion: @escaping (Result<[User], UserServiceError>) -> Void) {
        fetchUsers { result in
            switch result {
            case .success(let users):
                completion(.success(users.filter { ids.contains($0.id ?? "") }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
