import UIKit.UIImage
import CoreData

final class CoreDataService {
    private init() {}
    static let shared = CoreDataService()

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FaceMeetup")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    private func fetchPeople() throws -> [Person] {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        let result = try viewContext.fetch(request)
        return result
    }
}

extension CoreDataService: PeopleListDataSource {
    func fetchPeopleList() throws -> [PersonListItem] {
        try fetchPeople().map { PersonListItem(name: $0.name ?? "Unknown", picture: loadImage(with: $0.image ?? UUID()) ?? UIImage()) }
    }
}

extension CoreDataService: PersonAddService {
    func addPerson(with name: String, image: UIImage) {
        if let imageId = saveImageToDisk(image: image) {
            let person = Person(context: viewContext)
            person.name = name
            person.image = imageId

            saveContext()
        }
    }

    private func saveImageToDisk(image: UIImage) -> UUID? {
        let id = UUID()

        guard let data = image.pngData() else {
            return nil
        }

        let fileURL = FileManager.default.getDocumentsDirectory().appendingPathComponent("\(id.uuidString).faceMeetupImage")
        do {
            try data.write(to: fileURL, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
            return nil
        }

        return id
    }

    func loadImage(with id: UUID) -> UIImage? {
        let fileURL = FileManager.default.getDocumentsDirectory().appendingPathComponent("\(id.uuidString).faceMeetupImage")

        do {
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data)
        } catch {
            print("Unable to load saved data.")
            return nil
        }
    }

}
