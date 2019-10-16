//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Németh Gergely on 2019. 10. 16..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

/// Why does SwiftUI use “some View” for its view type?
struct SomeViewView: View {
    var body: some View {
        Button("Hello World") {
            print(type(of: self.body))
        }
        .background(Color.red)
        .foregroundColor(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}
/// Conditional modifiers
struct ConditionalModifiersView: View {
    @State private var useRedText = false
    var body: some View {
        Button("Hello world") {
            self.useRedText.toggle()
        }
        .background(useRedText ? Color.red : Color.green)
    }
}

/// Environment modifiers vs Regular modifiers (e.g.: .font vs .blur)
struct EnvironmentModifiersView: View {
    var body: some View {
        VStack {
            Text("Text A")
                .font(.title)
            Text("Text B")
            Text("Text C")
            Text("Text D")
        }
        .font(.largeTitle)
    }
}

/// Views as properties
struct ViewsAsPropertiesView: View {
    let motto1 = Text("Draco domiens")
    let motto2 = Text("nunquam titillandus")
    var motto1AsComputed: some View { Text("Draco domiens") }
    
    var body: some View {
        VStack {
            motto1
                .foregroundColor(.blue)
            motto2
                .foregroundColor(.orange)
            motto1AsComputed
                .background(Color.red)
        }
    }
}

/// ViewsComposition
struct CapsuleText: View {
    var text = ""
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct ViewsCompositionView: View {
    var body: some View {
        VStack {
            CapsuleText(text: "One")
                .foregroundColor(.yellow)
            CapsuleText(text: "Two")
                .foregroundColor(.pink)
        }
    }
}

/// Custom modifiers
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .foregroundColor(.white)
                .background(Color.blue)
        }
    }
}

extension View {
    func titleStyle() -> some View{
        modifier(Title())
    }
    
    func watermarked(text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct CustomModifiersView: View {
    var body: some View {
        VStack {
            Text("Hello world")
                .titleStyle()
            Text("Hello world")
                .frame(width: 200, height: 200)
                .background(Color.yellow)
                .watermarked(text: "Yes")
        }
    }
}
/// Custom Containers
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0..<rows) { row in
                HStack {
                    ForEach(0..<self.columns) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
    
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}

struct CustomContainersView: View {
    var body: some View {
        GridStack(rows: 4, columns: 4) { row, col in
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
        }
    }
}

struct Content_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SomeViewView()
            ConditionalModifiersView()
            EnvironmentModifiersView()
            ViewsAsPropertiesView()
            ViewsCompositionView()
            CustomModifiersView()
            CustomContainersView()
        }
    }
}
