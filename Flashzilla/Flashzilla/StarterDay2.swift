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

struct StarterDay2_4: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    var body: some View {
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }

            Text("Success")
        }
        .padding()
        .background(differentiateWithoutColor ? Color.black : Color.green)
        .foregroundColor(Color.white)
        .clipShape(Capsule())
    }
}

struct StarterDay2_5: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State var scale: CGFloat = 1

    var body: some View {
        Text("Hello, World!")
            .scaleEffect(scale)
            .onTapGesture {
                self.withOptionalAnimation {
                    self.scale *= 1.5
                }
            }
    }

    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
}

struct StarterDay2_6: View {
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    var body: some View {
        Text("Hello, World!")
            .padding()
            .background(reduceTransparency ? Color.black : Color.black.opacity(0.5))
            .foregroundColor(Color.white)
            .clipShape(Capsule())
    }
}

struct StarterDay2_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StarterDay2_1()
        }
    }
}
