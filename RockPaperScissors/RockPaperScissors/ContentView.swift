//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Németh Gergely on 2019. 10. 18..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

// "Paper" > "Rock" > "Scissors" (> "Paper")

enum Move: String {
    case paper = "🤚"
    case rock = "✊"
    case scissors = "✌️"
}

private let moves: [Move] = [.paper, .rock, .scissors]

struct ContentView: View {
    @State private var selectedMove = Int.random(in: 0..<moves.count)
    @State private var shouldWin = Bool.random()
    @State private var currentScore = 0
    @State private var currentRound = 1
    @State private var userSelectedMove = Move.rock
    
    @State private var showAlert = false
    
    private var shouldSelectToWinTheRound: Int {
        if shouldWin {
            return selectedMove - 1 >= 0 ? selectedMove - 1 : moves.count - 1
        } else {
            return selectedMove + 1 != moves.count ? selectedMove + 1 : 0
        }
    }
    
    private var didWon: Bool {
        return shouldSelectToWinTheRound == moves.firstIndex(of: userSelectedMove)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.red, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(shouldWin ? "Winner move against" : "Looser move against")
                    .font(.title)
                    .fontWeight(.black)
                    .padding()
                    .foregroundColor(.white)
                Text("\(moves[self.selectedMove].rawValue)")
                    .font(.largeTitle)
                    .padding()
                Color.white
                    .frame(maxHeight: 1)
                    .padding()
                HStack {
                    ForEach(moves, id: \.self) { move in
                        Button(action: {
                            self.evaluateMove(move)
                        }) {
                             Text(move.rawValue)
                                .font(.largeTitle)
                                .padding()
                                .overlay(Circle().stroke(Color.white))
                        }
                        .padding()
                    }
                }
                Text("Your current score is \(self.currentScore)")
                    .foregroundColor(.white)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Your score is \(currentScore)"), message: Text(currentScore > 0 ? "You did great! 😎" : "It will be better next time!"), dismissButton: .default(Text("Restart")) {
                self.currentScore = 0
            })
        }
    }
    
    
    
    private func evaluateMove(_ move: Move) {
        userSelectedMove = move
        self.currentRound += 1
        currentScore += didWon ? 1 : -1
        makeNewRound()
        if currentRound % 10 == 0 {
            showAlert = true
        }
    }
    
    private func makeNewRound() {
        self.selectedMove = Int.random(in: 0..<moves.count)
        self.shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
