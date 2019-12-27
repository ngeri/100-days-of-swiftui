//
//  Roll+Extension.swift
//  Dice
//
//  Created by Gergely Németh on 2019. 12. 27..
//  Copyright © 2019. Gergely Németh. All rights reserved.
//

import Foundation

extension Roll {
    var rollValue: Int { Int(value) }
    var rollMaxValue: Int { Int(maxValue) }
    var rollDate: Date { date ?? Date() }
}
