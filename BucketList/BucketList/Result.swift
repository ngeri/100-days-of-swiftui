//
//  Result.swift
//  BucketList
//
//  Created by Németh Gergely on 2019. 12. 03..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?

    static func < (lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }

    var description: String {
        terms?["description"]?.first ?? "No further information"
    }
}
