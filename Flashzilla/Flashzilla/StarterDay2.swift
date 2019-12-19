//
//  StarterDay2.swift
//  Flashzilla
//
//  Created by Gergely Németh on 2019. 12. 19..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

struct StarterDay2_1: View {
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0

    var body: some View {
        Text("Hello, World!")
            .onReceive(timer) { time in
                if self.counter == 5 {
                    self.timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }

                self.counter += 1
        }
    }
}

struct StarterDay2_2: View {
    var body: some View {
        Text("Hello, World!")
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                print("Moving to the background!")
            }
    }
}

struct StarterDay2_3: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct StarterDay2_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StarterDay2_1()
        }
    }
}
