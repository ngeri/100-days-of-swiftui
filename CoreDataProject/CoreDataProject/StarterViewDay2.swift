//
//  StarterView2.swift
//  CoreDataProject
//
//  Created by Németh Gergely on 2019. 11. 20..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

struct StarterView3: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: Ship.entity(),
        sortDescriptors: [],
//        predicate: NSPredicate(format: "universe == %@", "Star Wars")
//        predicate: NSPredicate(format: "name < %@", "F")
//        predicate: NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])
//        predicate: NSPredicate(format: "name BEGINSWITH %@", "E")
//        predicate: NSPredicate(format: "name BEGINSWITH[c] %@", "e")
//        predicate: NSPredicate(format: "name CONTAINS[c] %@", "e")
        predicate: NSPredicate(format: "(NOT name BEGINSWITH[c] %@) AND (NOT name BEGINSWITH[c] %@)", "e", "m")
    ) var ships: FetchedResults<Ship>

    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown name")
            }

            Button("Add Examples") {
                let ship1 = Ship(context: self.moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"

                let ship2 = Ship(context: self.moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"

                let ship3 = Ship(context: self.moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"

                let ship4 = Ship(context: self.moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"

                try? self.moc.save()
            }
        }
    }
}

struct StarterView4: View {
    @Environment(\.managedObjectContext) var moc
    @State var predicate: NSPredicate?

    var body: some View {
        VStack {
            FilteredList(predicate: predicate, sortDescriptors: [NSSortDescriptor(key: (\Singer.lastName).stringValue, ascending: false)]) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }

            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"

                try? self.moc.save()
            }

            Button("Show A") {
                self.predicate = NSPredicate.beginsWith.resolvePredicate(key: \Singer.lastName, value: "A")
            }
            .padding()
            Button("Show S") {
                self.predicate = NSPredicate.beginsWith.resolvePredicate(key: \Singer.lastName, value: "S")
            }
            .padding()
            Button("Show all") {
                self.predicate = nil
            }
            .padding()
        }
    }
}

struct StarterView5: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Country.entity(), sortDescriptors: []) var countries: FetchedResults<Country>
    var body: some View {
        VStack {
            List {
                ForEach(countries, id: \.self) { country in
                    Section(header: Text(country.wrappedFullName)) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }

            Button("Add") {
                let candy1 = Candy(context: self.moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: self.moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"

                let candy2 = Candy(context: self.moc)
                candy2.name = "KitKat"
                candy2.origin = Country(context: self.moc)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"

                let candy3 = Candy(context: self.moc)
                candy3.name = "Twix"
                candy3.origin = Country(context: self.moc)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"

                let candy4 = Candy(context: self.moc)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: self.moc)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"

                try? self.moc.save()
            }
        }
    }
}

struct StarterView2_Previews: PreviewProvider {
    static var previews: some View {
        StarterView3()
//        StarterView4()
    }
}

private extension ReferenceWritableKeyPath {
    var stringValue: String {
        NSExpression(forKeyPath: self).keyPath
    }
}

extension NSPredicate {
    enum PredicateType: String {
        case beginsWith = "BEGINSWITH"

        func resolvePredicate<T, U>(key: ReferenceWritableKeyPath<T, U?>, value: String) -> NSPredicate {
            return NSPredicate(format: "%K \(rawValue) %@", key.stringValue, value)
        }
    }

    static let beginsWith: PredicateType = .beginsWith
}
