//
//  ContentView.swift
//  Flashzilla
//
//  Created by Németh Gergely on 2019. 12. 18..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    @State private var cards = [Card]()
    @State private var timeRemaining = 100
    @State private var isActive = true
    @State private var showingEditScreen = false
    @State private var showingTimesUp = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.black)
                            .opacity(0.75)
                    )
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        self.cardView(for: index)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            VStack {
                HStack {
                    Spacer()

                    Button(action: {
                        self.showingEditScreen = true
                    }) {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }

                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            if differentiateWithoutColor || accessibilityEnabled {
                VStack {
                    Spacer()

                    HStack {
                        Button(action: {
                            withAnimation {
                                self.removeCard(at: self.cards.count - 1)
                            }
                        }) {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint: Text("Mark your answer as being incorrect."))
                        Spacer()

                        Button(action: {
                            withAnimation {
                                self.removeCard(at: self.cards.count - 1)
                            }
                        }) {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Correct"))
                        .accessibility(hint: Text("Mark your answer as being correct."))
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard self.isActive else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.showingTimesUp = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if self.cards.isEmpty == false {
                self.isActive = true
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            EditCards()
        }
        .alert(isPresented: $showingTimesUp) {
            Alert(title: Text("Time is up"), dismissButton: .default(Text("Reset"), action: { self.resetCards() }))
        }
        .onAppear(perform: resetCards)
    }

    func cardView(for index: Int) -> some View {
        CardView(card: self.cards[index]) { (success: Bool) in
           withAnimation {
                self.removeCard(at: index, success: success)
           }
        }
        .stacked(at: index, in: self.cards.count)
        .allowsHitTesting(index == self.cards.count - 1)
        .accessibility(hidden: index < self.cards.count - 1)
    }

    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded
            }
        }
    }

    func removeCard(at index: Int, success: Bool = true) {
        guard index >= 0 else { return }
        if success {
            cards.remove(at: index)
        } else {
            let card = cards.remove(at: index)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.cards.insert(card, at: 0)
            }
//            cards.move(fromOffsets: IndexSet(integer: index), toOffset: 0)
        }
        if cards.isEmpty {
            isActive = false
        }
    }

    func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .previewLayout(.fixed(width: 568, height: 320))
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}
