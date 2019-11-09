//
//  Activity.swift
//  Habits
//
//  Created by Németh Gergely on 2019. 11. 09..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import Foundation

struct Activity: Codable, Identifiable {
    let id: UUID
    let title: String
    let description: String
    var count: Int = 0
}
