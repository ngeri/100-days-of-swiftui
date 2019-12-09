import Combine

protocol PeopleListDataSource {
    func fetchPeopleList() throws -> [PersonListItem]
}

final class PeopleListViewModel: ObservableObject {
    @Published var navigationBarTitle = "People"
    @Published var dataSource: [PersonListItem] = []

    private let dataService: PeopleListDataSource

    init(dataService: PeopleListDataSource) {
        self.dataService = dataService
    }


    func fetchItems() {
        if let dataSource = try? dataService.fetchPeopleList() {
            self.dataSource = dataSource
        }
    }
}
