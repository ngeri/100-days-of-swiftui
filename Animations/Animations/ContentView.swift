//
//  ContentView.swift
//  Animations
//
//  Created by Németh Gergely on 2019. 10. 26..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

struct ContentView1: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        Button("Tap Me") {
            // Nothing to do
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle().stroke(Color.red)
                .scaleEffect(animationAmount)
                .opacity(Double(2 - animationAmount))
                .animation(
                    Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: false)
                )
        )
        .onAppear {
            self.animationAmount = 2
        }
        
    }
}

struct ContentView2: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        print(animationAmount)

        return VStack {
            Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)
            Spacer()
            Button("Tap Me") {
                self.animationAmount += 1
            }
            .padding(40)
            .background(Color.red)
            .foregroundColor(Color.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }
}

struct ContentView3: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
        Button("Tap Me") {
            withAnimation {
                self.animationAmount += 360
            }
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(Color.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView1()
            ContentView2()
            ContentView3()
        }
    }
}
