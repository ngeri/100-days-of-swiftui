//
//  UserListView.swift
//  Friends
//
//  Created by Gergely Németh on 2019. 11. 23..
//  Copyright © 2019. Gergely Németh. All rights reserved.
//

import SwiftUI

struct UserListView: View {
    // MARK: - View model
    @ObservedObject var viewModel: UserListViewModel
    private var users: [User] { return viewModel.users }

    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                list
                loadingIndicator
            }
            .navigationBarTitle("Users")
        }
    }

    // MARK: - Subviews
    private var list: some View {
        List {
            ForEach(users, id: \.id) { user in
                NavigationLink(destination: UserDetailView(viewModel: UserDetailViewModel(user: user))) {
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .foregroundColor(.primary)
                        Text(user.email)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }

    private var loadingIndicator: some View {
        VStack {
            if viewModel.isLoading {
                Text("Loading...")
            }
            ActivityIndicator(isAnimating: $viewModel.isLoading, style: .large)
        }
    }
}

// MARK: - Helpers
struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = UserListViewModel()
        return UserListView(viewModel: viewModel)
    }
}
