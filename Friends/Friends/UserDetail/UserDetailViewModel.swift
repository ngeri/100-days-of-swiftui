//
//  UserDetailViewModel.swift
//  Friends
//
//  Created by Gergely Németh on 2019. 11. 23..
//  Copyright © 2019. Gergely Németh. All rights reserved.
//

import Foundation

final class UserDetailViewModel: ObservableObject {
    @Published var user: User
    @Published var friends: [User] = []

    private let userService: UserService
    
    init(user: User, userService: UserService = UserService()) {
        self.user = user
        self.userService = userService
        fetchFriends(with: user.friends.map { $0.id } )
    }

    private func fetchFriends(with ids: [String]) {
        userService.fetchFriends(with: ids) { result in
            switch result {
            case .success(let friends):
                self.friends = friends
            case .failure(let error):
                self.friends = []
                print(error)
            }
        }
    }
}
