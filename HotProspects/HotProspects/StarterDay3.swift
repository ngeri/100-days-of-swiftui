//
//  StarterDay3.swift
//  HotProspects
//
//  Created by Gergely Németh on 2019. 12. 13..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SamplePackage
import UserNotifications
import SwiftUI

struct StarterDay3_1: View {
    @State private var backgroundColor = Color.red

    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
                .background(backgroundColor)

            Text("Change Color")
                .padding()
                .contextMenu {
                    Button(action: {
                        self.backgroundColor = .red
                    }) {
                        Text("Red")
                        if self.backgroundColor == .red {
                            Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.red)
                        }
                    }

                    Button(action: {
                        self.backgroundColor = .green
                    }) {
                        Text("Green")
                        if self.backgroundColor == .green {
                            Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        }
                    }

                    Button(action: {
                        self.backgroundColor = .blue
                    }) {
                        Text("Blue")
                        if self.backgroundColor == .blue {
                            Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                        }
                    }
            }
        }
    }
}

struct StarterDay3_2: View {
    var body: some View {
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }

            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default

                // show this notification five seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                // add our notification request
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

struct StarterDay3_3: View {
    let possibleNumbers = Array(1...60)
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
    var body: some View {
        Text(results)
    }
}

struct StarterDay3_Previews: PreviewProvider {
    static var previews: some View {
        StarterDay3_3()
    }
}
