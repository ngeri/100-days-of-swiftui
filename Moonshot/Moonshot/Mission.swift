//
//  Mission.swift
//  Moonshot
//
//  Created by Németh Gergely on 2019. 11. 02..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    
    func formattedCrewNames(for astronauts: [Astronaut]) -> String {
        ListFormatter().string(from: crew.compactMap { member in
            astronauts.first(where: { $0.id == member.name })?.name
        }) ?? ""
    }
}
