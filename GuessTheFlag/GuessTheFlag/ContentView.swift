//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Németh Gergely on 2019. 10. 13..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

struct Shake: GeometryEffect {
    var amount: CGFloat = 12
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)), y: 0))
    }
}

struct FlagImage: View {
    var imageName: String
    var rotation: Double
    var fade: Double
    var shake: CGFloat

    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black))
            .shadow(color: .black, radius: 2)
            .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
            .opacity(fade)
            .modifier(Shake(animatableData: shake))
    }
}

struct ContentView: View {
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var buttonRotations: [Double] = [0, 0, 0]
    @State private var buttonFades: [Double] = [1, 1, 1]
    @State private var wrong: [CGFloat] = [0, 0, 0]
    @State private var disabled = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(self.countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    Text("Your current score is \(score).")
                        .foregroundColor(.white)
                        .font(.footnote)
                        
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(imageName: self.countries[number], rotation: self.buttonRotations[number], fade: self.buttonFades[number], shake: self.wrong[number])
                            .accessibility(label: Text(self.labels[self.countries[number], default: "Unknown flag"]))
                            .animation(Animation.default.delay(0.25))
                    }
                }
                
                Spacer()
            }
        }
        .disabled(disabled)
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(self.score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            self.buttonRotations[number] += 360
            self.buttonFades = [0.25, 0.25, 0.25]
            self.buttonFades[number] = 1
        } else {
            self.buttonFades = [0.25, 0.25, 0.25]
            self.wrong[number] += 1
            scoreTitle = "Wrong! That's the flag of \(self.countries[number])"
        }
        self.disabled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.disabled = false
            self.showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        withAnimation {
            self.buttonFades = [1, 1, 1]
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
