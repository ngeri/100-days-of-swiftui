//
//  ChallangeDay.swift
//  Drawing
//
//  Created by Németh Gergely on 2019. 11. 08..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

struct Arrow: InsettableShape {
    var insetAmount: CGFloat = 0
    var ratio: CGFloat
    var widthRatio: CGFloat

    typealias AnimatableData = AnimatablePair<CGFloat, CGFloat>

    var animatableData: AnimatableData {
        get {
            AnimatableData(ratio, widthRatio)
        }
        set {
            self.ratio = newValue.first
            self.widthRatio = newValue.second
        }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.width - insetAmount, y: rect.height * ratio))
        path.addLine(to: CGPoint(x: rect.width / 2, y: insetAmount))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.height * ratio))
        path.addLine(to: CGPoint(x: rect.width / 2 * (1 - widthRatio), y: rect.height * ratio))
        path.addLine(to: CGPoint(x: rect.width / 2 * (1 - widthRatio), y: rect.height - insetAmount))
        path.addLine(to: CGPoint(x: rect.width / 2 * (1 + widthRatio), y: rect.height - insetAmount))
        path.addLine(to: CGPoint(x: rect.width / 2 * (1 + widthRatio), y: rect.height * ratio))
        path.closeSubpath()

        return path
    }

    func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }
}

struct ContentView: View {
    @State private var ratio: CGFloat = 0.25
    @State private var widthRatio: CGFloat = 0.25

    var body: some View {
        Arrow(ratio: ratio, widthRatio: widthRatio)
            .fill(Color.gray)
            .overlay(
                Arrow(ratio: ratio, widthRatio: widthRatio)
                    .strokeBorder(Color.blue, style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
            )
            .onTapGesture {
                withAnimation {
                    self.ratio = CGFloat.random(in: 0.2...0.8)
                    self.widthRatio = CGFloat.random(in: 0.2...0.8)
                }
            }
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [self.color(for: value, brightness: 1), self.color(for: value, brightness: 0.1)]), startPoint: .topTrailing, endPoint: .bottomLeading), lineWidth: 1)
            }
        }
        .drawingGroup()
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView2: View {
    @State private var colorCycle = 0.0

    var body: some View {
        VStack {
            ColorCyclingRectangle(amount: self.colorCycle)
                .frame(width: 300, height: 300)

            Slider(value: $colorCycle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView2()
        }
    }
}
