//
//  PersonDetailView.swift
//  FaceMeetup
//
//  Created by Németh Gergely on 2019. 12. 10..
//  Copyright © 2019. Gergely Németh. All rights reserved.
//

import SwiftUI

struct PersonDetailView: View {
    @State var person: PersonListItem

    var body: some View {
        VStack {
            Image(uiImage: person.picture)
                .resizable()
                .scaledToFit()
            Text(person.name)
            Spacer()
        }
    }
}
