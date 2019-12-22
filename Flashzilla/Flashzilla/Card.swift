//
//  Card.swift
//  Flashzilla
//
//  Created by Gergely Németh on 2019. 12. 20..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

struct Card: Codable {
    let prompt: String
    let answer: String

    static var example: Card {
        Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
