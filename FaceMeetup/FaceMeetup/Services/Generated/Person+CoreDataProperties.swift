//
//  Person+CoreDataProperties.swift
//  FaceMeetup
//
//  Created by Németh Gergely on 2019. 12. 10..
//  Copyright © 2019. Gergely Németh. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var image: UUID?
    @NSManaged public var name: String?
    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double

}
