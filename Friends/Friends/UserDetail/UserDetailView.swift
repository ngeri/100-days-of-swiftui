//
//  UserDetailView.swift
//  Friends
//
//  Created by Gergely Németh on 2019. 11. 23..
//  Copyright © 2019. Gergely Németh. All rights reserved.
//

import CoreData
import SwiftUI

struct UserDetailView: View {
    // MARK: - ViewModel
    @ObservedObject var viewModel: UserDetailViewModel
    private var user: User { return viewModel.user }
    private var friends: [User] { return viewModel.friends }
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }

    // MARK: - Body
    var body: some View {
        Form {
            Section(header: Text("Address")) {
                Text(user.address)
            }
            Section(header: Text("Age")) {
                Text("\(user.age)")
            }
            Section(header: Text("Registered")) {
                Text(dateFormatter.string(from: user.registered ?? Date()))
            }
            Section(header: Text("About")) {
                Text("\(user.about)")
            }
            Section(header: Text("Friends")) {
                friendsList
            }
        }
        .navigationBarTitle(user.name)
    }

    // MARK: - Subviews
    private var friendsList: some View {
        List {
            ForEach(viewModel.friends, id: \.id) { friend in
                NavigationLink(destination: UserDetailView(viewModel: UserDetailViewModel(user: friend))) {
                    VStack(alignment: .leading) {
                        Text(friend.name)
                            .foregroundColor(.primary)
                        Text(friend.email)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}

// MARK: - Helpers
struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = UserDetailViewModel(user: User.mock)
        return NavigationView {
            UserDetailView(viewModel: viewModel)
        }
    }
}
