//
//  ActivitiesView.swift
//  Habits
//
//  Created by Németh Gergely on 2019. 11. 09..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

struct ActivitiesView: View {
    @ObservedObject var activities = ActivitiesModel()
    @State private var isNewActivityPresented: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.activities.activities) { activity in
                    NavigationLink(destination: ActivityView(activities: self.activities, activityId: activity.id)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(activity.title)
                                    .font(.title)
                                Text(activity.description)
                                    .font(.caption)
                            }
                            Spacer()
                            Text("\(activity.count)")
                        }
                        
                    }
                }
            }
            .navigationBarTitle("Your activities")
            .navigationBarItems(trailing: Button(action: { self.isNewActivityPresented.toggle() }, label: { Image(systemName: "plus") }))
            .sheet(isPresented: $isNewActivityPresented) {
                AddNewActivityView(activities: self.activities)
            }
        }
    }
}

struct ActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesView()
    }
}
