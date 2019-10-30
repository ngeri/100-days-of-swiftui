//
//  Question.swift
//  Multiply
//
//  Created by Németh Gergely on 2019. 10. 30..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import Foundation

struct Question {
    let firstNumber: Int
    let secondNumber: Int
    var result: Int {
        firstNumber * secondNumber
    }
}
