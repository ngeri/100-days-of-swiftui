//
//  ContentView.swift
//  Multiply
//
//  Created by Németh Gergely on 2019. 10. 30..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

// Very bad code... sorry to even put it on Github please look away :(

import SwiftUI

struct MenuView: View {
    @State private var isGameActive = false
    @State private var multiplicationTableValue: Int = 5
    @State private var questionCountIndex: Int = 1
    @State private var game: Game?
    
    var body: some View {
        Form {
            Section {
                Stepper("Up to \(multiplicationTableValue)", value: $multiplicationTableValue, in: 1...12)
            }
            
            Section {
                Text("How many questions do you want to answer?")
                Picker(selection: $questionCountIndex, label: Text("What level do you want to play?")) {
                    ForEach(0..<Difficulty.allCases.count) {
                        Text("\(Difficulty.allCases[$0].formattedValue)")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Button(action: {
                self.startGame()
                self.isGameActive.toggle()
            }) {
                Text("Lets start!")
            }
        }
        .sheet(isPresented: $isGameActive) {
            GameView(game: self.$game, showModal: self.$isGameActive, results: Array(repeating: Result.unknown, count: self.game!.questions.count))
        }
    }
    
    private func startGame() {
        game = Game(upToNumber: multiplicationTableValue, difficulty: Difficulty.allCases[questionCountIndex])
    }
}

enum Result {
    case unknown
    case good
    case bad
}

struct GameView: View {
    @Binding var game: Game?
    @Binding var showModal: Bool
    
    @State var results: [Result]
    @State var current: Int = 0
    
    @State private var text = ""
    
    var body: some View {
        Form {
            HStack {
                ForEach(0..<results.count) {
                    CircleView(result: self.results[$0])
                }
            }
            Section {
                Text("\(game!.questions[current].firstNumber)*\(game!.questions[current].secondNumber)")
            }
            Section {
                TextField("Result", text: $text, onCommit: next)
                    .keyboardType(.numbersAndPunctuation)
            }
        }
    }
    
    func next() {
        let currentQuestion = game!.questions[current]
        results[current] = currentQuestion.result == Int(text) ? .good : .bad
        text = ""
        if current < game!.questions.count - 1 {
            current += 1
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showModal = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct CircleView: View {
    let result: Result
    
    var body: some View {
        ZStack {
            Circle()
                .fill(result == .good ? Color.green : result == .bad ? Color.red : Color.gray)
                .frame(width: 6, height: 6)
        }
    }
}
