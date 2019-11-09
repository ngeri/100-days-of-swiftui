//
//  ActivitiesModel.swift
//  Habits
//
//  Created by Németh Gergely on 2019. 11. 09..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import Foundation

final class ActivitiesModel: ObservableObject {
    @Published var activities: [Activity] { didSet { saveActivities() } }
    
    init() {
        let activityData = UserDefaults.standard.data(forKey: "activities") ?? Data()
        self.activities = (try? JSONDecoder().decode([Activity].self, from: activityData)) ?? []
    }
    
    private func saveActivities() {
        do {
            let activityData = try JSONEncoder().encode(activities)
            UserDefaults.standard.set(activityData, forKey: "activities")
        } catch {
            print("Something happened")
        }
    }
}
