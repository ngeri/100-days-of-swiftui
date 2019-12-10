import MapKit
import SwiftUI

struct PeopleListView: View {
    @ObservedObject var viewModel: PeopleListViewModel
    @State private var addSheetIsPresented = false

    var body: some View {
        NavigationView {
            contentView
                .navigationBarTitle(viewModel.navigationBarTitle)
                .navigationBarItems(trailing: Button(action: {
                    self.addSheetIsPresented = true
                }) {
                    Image(systemName: "plus")
                })
                .onAppear(perform: viewModel.fetchItems)
                .sheet(isPresented: $addSheetIsPresented) {
                    PersonAddView(viewModel: PersonAddViewModel(personAddService: CoreDataService.shared))
                }
        }
    }

    private var contentView: some View {
        List {
            ForEach(viewModel.dataSource, id: \.name) { person in
                NavigationLink(destination: PersonDetailView(person: person)) {
                    HStack {
                        Image(uiImage: person.picture)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        Text(person.name)
                            .font(.title)
                    }
                }
            }
        }
    }
}

struct PeopleListView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleListView(viewModel: PeopleListViewModel(dataService: DataServiceMock()))
    }
}

extension DataServiceMock: PeopleListDataSource {
    func fetchPeopleList() throws -> [PersonListItem] {
        [
            PersonListItem(name: "N. G. 1", picture: UIImage(systemName: "plus")!, location: MKPointAnnotation.example.coordinate),
            PersonListItem(name: "N. G. 2", picture: UIImage(systemName: "plus")!, location: MKPointAnnotation.example.coordinate),
            PersonListItem(name: "N. G. 3", picture: UIImage(systemName: "plus")!, location: MKPointAnnotation.example.coordinate)
        ]
    }
}
