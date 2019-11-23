//
//  UserListViewModel.swift
//  Friends
//
//  Created by Gergely Németh on 2019. 11. 23..
//  Copyright © 2019. Gergely Németh. All rights reserved.
//

import Foundation

final class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading: Bool = true

    private let userService: UserService

    init(userService: UserService = UserService()) {
        self.userService = userService
        fetchUsers()
    }

    private func fetchUsers() {
        isLoading = true
        userService.fetchUsers(completion: { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let users):
                self?.users = users
            case .failure(let error):
                self?.users = []
                print(error)
            }
        })
    }
}
