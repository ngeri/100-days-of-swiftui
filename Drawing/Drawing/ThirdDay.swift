//
//  ContentView.swift
//  Drawing
//
//  Created by Németh Gergely on 2019. 11. 07..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

//struct ContentView: View {
//    var body: some View {
//        Image("image")
//            .colorMultiply(.red)
//    }
//}

//struct ContentView: View {
//    @State private var amount: CGFloat = 0.0
//
//    var body: some View {
//        VStack {
//            ZStack {
//                Circle()
//                    .fill(Color(red: 1, green: 0, blue: 0))
//                    .frame(width: 200 * amount)
//                    .offset(x: -50, y: -80)
//                    .blendMode(.screen)
//
//                Circle()
//                    .fill(Color(red: 0, green: 1, blue: 0))
//                    .frame(width: 200 * amount)
//                    .offset(x: 50, y: -80)
//                    .blendMode(.screen)
//
//                Circle()
//                    .fill(Color(red: 0, green: 0, blue: 1))
//                    .frame(width: 200 * amount)
//                    .blendMode(.screen)
//            }
//            .frame(width: 300, height: 300)
//
//            Slider(value: $amount)
//                .padding()
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.black)
//        .edgesIgnoringSafeArea(.all)
//    }
//}

//struct ContentView: View {
//    @State private var amount: CGFloat = 0.0
//
//    var body: some View {
//        VStack {
//            Image("image")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 200, height: 200)
//                .blur(radius: (1 - amount) * 20)
//
//            Slider(value: $amount)
//                .padding()
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.black)
//        .edgesIgnoringSafeArea(.all)
//    }
//}

//struct Trapezoid: Shape {
//    var insetAmount: CGFloat
//
//    var animatableData: CGFloat {
//        get { insetAmount }
//        set { self.insetAmount = newValue }
//    }
//
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//        path.move(to: CGPoint(x: 0, y: rect.maxY))
//        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
//
//        return path
//   }
//}
//
//struct ContentView: View {
//    @State private var insetAmount: CGFloat = 50
//
//    var body: some View {
//        Trapezoid(insetAmount: insetAmount)
//            .frame(width: 200, height: 100)
//            .onTapGesture {
//                withAnimation {
//                    self.insetAmount = CGFloat.random(in: 10...90)
//                }
//            }
//    }
//}

//struct Checkerboard: Shape {
//    var rows: Double
//    var columns: Double
//
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        let rowSize = rect.height / CGFloat(rows)
//        let columnSize = rect.width / CGFloat(columns)
//        for row in 0..<Int(rows) {
//            for column in 0..<Int(columns) {
//                if (row + column).isMultiple(of: 2) {
//                    let startX = columnSize * CGFloat(column)
//                    let startY = rowSize * CGFloat(row)
//                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
//                    path.addRect(rect)
//                }
//            }
//        }
//
//        return path
//    }
//
//    public var animatableData: AnimatablePair<Double, Double> {
//        get {
//           AnimatablePair(Double(rows), Double(columns))
//        }
//
//        set {
//            self.rows = Double(newValue.first)
//            self.columns = Double(newValue.second)
//        }
//    }
//}
//
//struct ContentView: View {
//    @State private var rows: Double = 4
//    @State private var columns: Double = 4
//
//    var body: some View {
//        Checkerboard(rows: rows, columns: columns)
//            .onTapGesture {
//                withAnimation(.linear(duration: 3)) {
//                    if rows == 8 {
//                        self.rows = 4
//                        self.columns = 4
//                    } else {
//                        self.rows = 8
//                        self.columns = 8
//                    }
//
//                }
//            }
//    }
//}

//struct Spirograph: Shape {
//    let innerRadius: Int
//    let outerRadius: Int
//    let distance: Int
//    let amount: CGFloat
//
//    func path(in rect: CGRect) -> Path {
//        let divisor = gcd(innerRadius, outerRadius)
//        let outerRadius = CGFloat(self.outerRadius)
//        let innerRadius = CGFloat(self.innerRadius)
//        let distance = CGFloat(self.distance)
//        let difference = innerRadius - outerRadius
//        let endPoint = ceil(2 * CGFloat.pi * outerRadius / CGFloat(divisor)) * amount
//
//        var path = Path()
//
//        for theta in stride(from: 0, through: endPoint, by: 0.01) {
//            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
//            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)
//
//            x += rect.width / 2
//            y += rect.height / 2
//
//            if theta == 0 {
//                path.move(to: CGPoint(x: x, y: y))
//            } else {
//                path.addLine(to: CGPoint(x: x, y: y))
//            }
//        }
//
//        return path
//    }
//
//    func gcd(_ a: Int, _ b: Int) -> Int {
//        var a = a
//        var b = b
//
//        while b != 0 {
//            let temp = b
//            b = a % b
//            a = temp
//        }
//
//        return a
//    }
//}

//struct ContentView: View {
//    @State private var innerRadius = 125.0
//    @State private var outerRadius = 75.0
//    @State private var distance = 25.0
//    @State private var amount: CGFloat = 1.0
//    @State private var hue = 0.6
//
//    var body: some View {
//        VStack(spacing: 0) {
//            Spacer()
//
//            Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount)
//                .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
//                .frame(width: 300, height: 300)
//
//            Spacer()
//
//            Group {
//                Text("Inner radius: \(Int(innerRadius))")
//                Slider(value: $innerRadius, in: 10...150, step: 1)
//                    .padding([.horizontal, .bottom])
//
//                Text("Outer radius: \(Int(outerRadius))")
//                Slider(value: $outerRadius, in: 10...150, step: 1)
//                    .padding([.horizontal, .bottom])
//
//                Text("Distance: \(Int(distance))")
//                Slider(value: $distance, in: 1...150, step: 1)
//                    .padding([.horizontal, .bottom])
//
//                Text("Amount: \(amount, specifier: "%.2f")")
//                Slider(value: $amount)
//                    .padding([.horizontal, .bottom])
//
//                Text("Color")
//                Slider(value: $hue)
//                    .padding(.horizontal)
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
