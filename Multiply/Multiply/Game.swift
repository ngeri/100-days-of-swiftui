//
//  Game.swift
//  Multiply
//
//  Created by Németh Gergely on 2019. 10. 30..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import Foundation

struct Game {
    let upToNumber: Int
    let difficulty: Difficulty
    let questions: [Question]
    
    init(upToNumber: Int, difficulty: Difficulty) {
        self.upToNumber = upToNumber
        self.difficulty = difficulty
        switch difficulty {
        case .easy, .medium, .hard:
            let all = Self.generateAll(upToNumber: upToNumber).shuffled()
            if difficulty.rawValue < all.count {
                self.questions = Array(all[0..<difficulty.rawValue])
            } else {
                self.questions = all
            }
            
        case .all:
            self.questions = Self.generateAll(upToNumber: upToNumber).shuffled()
        }
    }
    
    private static func generateAll(upToNumber: Int) -> [Question] {
        return (1...upToNumber).reduce(into: [Question](), { result, firstNumber in
            (1...9).forEach {
                secondNumber in result.append(Question(firstNumber: firstNumber, secondNumber: secondNumber))
            }
        })
    }
}
