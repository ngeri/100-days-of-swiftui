//
//  User+CoreDataClass.swift
//  Friends
//
//  Created by Gergely Németh on 2019. 11. 23..
//  Copyright © 2019. Gergely Németh. All rights reserved.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Decodable {

    enum CodingKeys: String, CodingKey {
        case id
        case isActive
        case name
        case age
        case company
        case email
        case address
        case about
        case registered
        case tags
        case friends
    }

    public required convenience init(from decoder: Decoder) throws {
        let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.init(context: moc)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.age = try container.decode(Int16.self, forKey: .age)
        self.company = try container.decodeIfPresent(String.self, forKey: .company)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.address = try container.decodeIfPresent(String.self, forKey: .address)
        self.about = try container.decodeIfPresent(String.self, forKey: .about)
        self.registered = try container.decodeIfPresent(Date.self, forKey: .registered)
        self.tags = []
        self.friends = []
        try moc.save()
    }
}

extension User {

    static var mock: User {
        let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        let user = User(context: moc)
        user.id = "id"
        user.isActive = true
        user.name = "Gergely Nemeth"
        user.age = 24
        user.company = "Black Swan"
        user.email = "geri.nemeth@blackswan.com"
        user.address = "8438, Veszpremvarsany Szolo utca 9"
        user.about = "Jo fej gyerek"
        user.registered = Date(timeIntervalSince1970: 1574035200)
        user.tags = [""]
        user.friends = [""]
        return user
    }
}

