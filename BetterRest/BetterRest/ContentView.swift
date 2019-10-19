//
//  ContentView.swift
//  BetterRest
//
//  Created by Németh Gergely on 2019. 10. 19..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date()
    
    var body: some View {
        DatePicker("Please enter a date!", selection: $wakeUp, displayedComponents: .hourAndMinute)
        .labelsHidden()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
