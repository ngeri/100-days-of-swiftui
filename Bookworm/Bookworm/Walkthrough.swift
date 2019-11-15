//
//  Walkthrough.swift
//  Bookworm
//
//  Created by Németh Gergely on 2019. 11. 15..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool

    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]

    var body: some View {
        Button(title) {
            self.isOn.toggle()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}

//struct Walkthrough: View {
//    @State private var rememberMe = false
//
//    var body: some View {
//        return VStack {
//            PushButton(title: "Remember Me", isOn: $rememberMe)
//            Text(rememberMe ? "On" : "Off")
//        }
//    }
//}

//struct Walkthrough: View {
//    @Environment(\.horizontalSizeClass) var sizeClass
//
//    var body: some View {
//        Group {
//            if sizeClass == .compact {
//                VStack {
//                    Text("Active size class:")
//                    Text("COMPACT")
//                }
//                .font(.largeTitle)
//            } else {
//                HStack {
//                    Text("Active size class:")
//                    Text("REGULAR")
//                }
//                .font(.largeTitle)
//            }
//        }
//    }
//}


//
//struct Walkthrough: View {
//    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
//
//    var body: some View {
//        VStack {
//            List {
//                ForEach(students, id: \.id) { student in
//                    Text(student.name ?? "Unknown")
//                }
//            }
//            Button("Add") {
//                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
//                let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
//
//                let chosenFirstName = firstNames.randomElement()!
//                let chosenLastName = lastNames.randomElement()!
//
//                let student = Student(context: self.moc)
//                student.id = UUID()
//                student.name = "\(chosenFirstName) \(chosenLastName)"
//
//                try? self.moc.save()
//            }
//        }
//    }
//}

struct Walkthrough_Previews: PreviewProvider {
    static var previews: some View {
        Walkthrough()
    }
}
