//
//  AddNewActivityView.swift
//  Habits
//
//  Created by Németh Gergely on 2019. 11. 09..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

struct AddNewActivityView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var activities: ActivitiesModel
    @State private var activityTitle: String = ""
    @State private var activityDescription: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $activityTitle)
                }
                Section {
                    TextField("Description", text: $activityDescription)
                }
                
                Section {
                    Button(action: {
                        self.activities.activities.append(Activity(id: UUID(), title: self.activityTitle, description: self.activityDescription))
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                    }
                }
            }
            .navigationBarTitle("Add a new activity")
        }
    }
}

struct AddNewActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewActivityView(activities: ActivitiesModel())
    }
}
