//
//  StarterView.swift
//  CoreDataProject
//
//  Created by Németh Gergely on 2019. 11. 20..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import CoreData
import SwiftUI

struct Student: Hashable {
    let name: String
}

struct StarterView: View {
    let students = [Student(name: "Harry Potter"), Student(name: "Hermione Granger")]

    var body: some View {
        List(students, id: \.self) { student in
            Text(student.name)
        }
    }
}

struct StarterView2: View {
    @Environment(\.managedObjectContext) var moc

    @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>

    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }

            Button("Add") {
                let wizard = Wizard(context: self.moc)
                wizard.name = "Harry Potter"
            }

            Button("Save") {
                do {
                    try self.moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}


struct StarterView_Previews_2: PreviewProvider {
    static var previews: some View {
        Group {
            StarterView()
            StarterView2()
        }
    }
}
