//
//  Difficulty.swift
//  Multiply
//
//  Created by Németh Gergely on 2019. 10. 30..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import Foundation

enum Difficulty: Int, CaseIterable {
    case easy = 5
    case medium = 10
    case hard = 20
    case all = -1

    var formattedValue: String {
        switch self {
        case .easy: return "5"
        case .medium: return "10"
        case .hard: return "20"
        case .all: return "All"
        }
    }
}
