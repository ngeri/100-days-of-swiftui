//
//  CardView.swift
//  Flashzilla
//
//  Created by Gergely Németh on 2019. 12. 20..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

struct CardView: View {
    @State var isShowingAnswer = false
    @State var offset = CGSize.zero
    let card: Card
    var removal: (() -> Void)? = nil

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .shadow(radius: 10)

            VStack {
                Text(card.prompt)
                    .font(.largeTitle)

                if isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundColor(.secondary)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                }

                .onEnded { _ in
                    if abs(self.offset.width) > 100 {
                        self.removal?()
                    } else {
                        self.offset = .zero
                    }
                }
        )
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
            .previewLayout(.fixed(width: 568, height: 320))
    }
}
