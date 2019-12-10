import MapKit
import SwiftUI

struct PersonDetailView: View {
    @State var person: PersonListItem

    var body: some View {
        VStack {
            Text(person.name)
            Image(uiImage: person.picture)
                .resizable()
                .scaledToFit()
            MapView(centerCoordinate: person.location, location: MKPointAnnotation(__coordinate: person.location))
            Spacer()
        }
    }
}
