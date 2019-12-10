import UIKit.UIImage
import Combine
import CoreLocation

protocol PersonAddService {
    func addPerson(with name: String, image: UIImage, location: CLLocationCoordinate2D)
}

final class PersonAddViewModel: ObservableObject {
    @Published var navigationBarTitle = "Add new person"
    private let personAddService: PersonAddService

    init(personAddService: PersonAddService) {
        self.personAddService = personAddService
    }

    func addPerson(with name: String, image: UIImage, location: CLLocationCoordinate2D) {
        personAddService.addPerson(with: name, image: image, location: location)
    }
}
