//
//  RollDiceView.swift
//  Dice
//
//  Created by Gergely Németh on 2019. 12. 27..
//  Copyright © 2019. Gergely Németh. All rights reserved.
//

import SwiftUI

struct RollDiceView: View {
    @Environment(\.managedObjectContext) private var moc
    @State private var lastResult: Int?
    private let minValue: Int = 1
    let feedback = UINotificationFeedbackGenerator()


    @State private var selectedDice = 4
    private static let dices =  [4, 6, 8, 20]

    @State private var nextRollTime: TimeInterval = 0.1

    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: self.$selectedDice, label: Text("Select the dice")) {
                    ForEach(Self.dices, id: \.self) { sideCount in
                        Text("\(sideCount) sided")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                Button(action: self.rolling) {
                    Text("Roll the dice")
                }

                if lastResult != nil {
                    GeometryReader { geo in
                        Image(systemName: "\(self.lastResult!).circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.blue)
                            .frame(width: geo.size.width * 0.6, height: geo.size.width * 0.6)
                    }.aspectRatio(contentMode: .fit)
                }

                Spacer()
            }
            .navigationBarTitle("Roll the dice")
        }
    }

    private func rolling() {
        lastResult = Int.random(in: minValue...selectedDice)
        feedback.notificationOccurred(.success)
        if nextRollTime < 0.75 {
            nextRollTime = nextRollTime * 2
            DispatchQueue.main.asyncAfter(deadline: .now() + nextRollTime) {
                self.rolling()
            }
        } else {
            resetRollingConstants()
            saveResult()
        }
    }

    private func resetRollingConstants() {
        nextRollTime = 0.05
    }

    private func saveResult() {
        let newRoll = Roll(context: moc)
        newRoll.date = Date()
        newRoll.maxValue = Int16(selectedDice)
        newRoll.value = Int16(lastResult ?? 0)
        do {
            try moc.save()
        } catch  {
            print("Error during saving new roll")
        }
    }
}

struct RollDiceView_Previews: PreviewProvider {
    static var previews: some View {
        RollDiceView()
    }
}
