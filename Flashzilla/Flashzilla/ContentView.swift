//
//  ContentView.swift
//  Flashzilla
//
//  Created by Németh Gergely on 2019. 12. 18..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var cards = [Card](repeating: Card.example, count: 10)

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: self.cards[index]) {
                           withAnimation {
                               self.removeCard(at: index)
                           }
                        }
                        .stacked(at: index, in: self.cards.count)
                    }
                }
            }
        }
    }

    func removeCard(at index: Int) {
        cards.remove(at: index)
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
