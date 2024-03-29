//
//  ContentView.swift
//  WordScramble
//
//  Created by Németh Gergely on 2019. 10. 22..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var points = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack {
                    TextField("Enter your word", text: self.$newWord, onCommit: self.addNewWord)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .padding()

                    List(self.usedWords + ["aaa", "aaaa", "aaa","aaaa", "aaa", "aaaa", "aaa", "aaaa", "aaa", "aaaa", "aaa", "aaaa", "aaa","aaaa", "aaa", "aaaa", "aaa", "aaaa", "aaa", "aaaa"], id: \.self) { word in
                        self.cellView(word: word, globalGeo: geo)
                            .accessibilityElement(children: .ignore)
                            .accessibility(label: Text("\(word), \(word.count) letters"))
                    }

                    Text("State: \(self.points)")
                }
                .navigationBarTitle(self.rootWord)
                .navigationBarItems(trailing: Button(action: self.startGame) { Text("Start Over") } )
                .onAppear(perform: self.startGame)
                .alert(isPresented: self.$showingError) {
                    Alert(title: Text(self.errorTitle), message: Text(self.errorMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
    }

    func cellView(word: String, globalGeo: GeometryProxy) -> some View {
        GeometryReader { geo in
            HStack {
                Image(systemName: "\(word.count).circle")
                    .foregroundColor(self.calcColor(localGeo: geo, globalGeo: globalGeo))
                Text(word)
                Spacer()
            }
            .offset(CGSize(width: self.calcOffset(localGeo: geo, globalGeo: globalGeo), height: 0))
        }
    }

    private func calcColor(localGeo: GeometryProxy, globalGeo: GeometryProxy) -> Color {
        let height = globalGeo.size.height + globalGeo.safeAreaInsets.top
        let originY = localGeo.frame(in: .global).origin.y
        let ratio = Double((height - originY)/height)
        return Color(red: ratio, green: 1 - ratio, blue: 1 - ratio)
    }

    private func calcOffset(localGeo: GeometryProxy, globalGeo: GeometryProxy) -> CGFloat {
        let height = globalGeo.size.height + globalGeo.safeAreaInsets.top
        let origin = localGeo.frame(in: .global).origin

        let a: CGFloat = 200
        if height - origin.y < a {
            return (1 - (height - origin.y)/a) * globalGeo.size.width
        } else {
            return 0
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }

        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real world!")
            return
        }

        usedWords.insert(answer, at: 0)
        newWord = ""
        points += answer.count
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                usedWords = []
                rootWord = allWords.randomElement() ?? "silkworm"
                newWord = ""
                points = 0
                return
            }
        }
        fatalError("Could not load start.txt from bundle!")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        guard word.count > 2 else {
            return false
        }
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
