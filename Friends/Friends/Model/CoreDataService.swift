//
//  CoreDataService.swift
//  Friends
//
//  Created by Gergely Németh on 2019. 11. 23..
//  Copyright © 2019. Gergely Németh. All rights reserved.
//

import CoreData

final class CoreDataService {
    private init() {}
    static let shared = CoreDataService()

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Friends")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    static func saveContext() {
        let context = shared.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func fetch() -> [User] {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        return try! persistentContainer.viewContext.fetch(fetchRequest)
    }
}
