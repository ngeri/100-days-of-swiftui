//
//  ActivityView.swift
//  Habits
//
//  Created by Németh Gergely on 2019. 11. 09..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

struct ActivityView: View {
    @ObservedObject var activities: ActivitiesModel
    let activityId: UUID
    
    var body: some View {
        let activity = activities.activities.first(where: { $0.id == self.activityId } )!
        return List {
            Section {
                Text(activity.description)
            }
            
            Section(header: Text("Counter")) {
                HStack {
                    Text("\(activity.count)")
                        .font(.largeTitle)
                }
            }
            
            
            Button(action: {
                if let index = self.activities.activities.firstIndex(where: { $0.id == activity.id}) {
                    self.activities.activities[index] = Activity(id: activity.id, title: activity.title, description: activity.description, count: activity.count + 1)
                }
            }) {
                Image(systemName: "plus")
            }
            
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(activity.title)
    }
}

//struct ActivityView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            ActivityView(activities: ActivitiesModel(), activity: Activity(title: "Title", description: "Description", count: 10))
//        }
//    }
//}
