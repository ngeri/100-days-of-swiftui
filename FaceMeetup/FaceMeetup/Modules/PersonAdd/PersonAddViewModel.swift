import UIKit.UIImage
import Combine

protocol PersonAddService {
    func addPerson(with name: String, image: UIImage)
}

final class PersonAddViewModel: ObservableObject {
    @Published var navigationBarTitle = "Add new person"
    private let personAddService: PersonAddService

    init(personAddService: PersonAddService) {
        self.personAddService = personAddService
    }

    func addPerson(with name: String, image: UIImage) {
        personAddService.addPerson(with: name, image: image)
    }
}
