//
//  ContentView.swift
//  Dice
//
//  Created by Gergely Németh on 2019. 12. 27..
//  Copyright © 2019. Gergely Németh. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            rollDiceTabItem
            resultsTabItem
        }
    }

    private var rollDiceTabItem: some View {
        RollDiceView()
            .tabItem {
                Image(systemName: "rotate.left.fill")
                Text("One")
            }
    }

    private var resultsTabItem: some View {
        ResultsView()
            .tabItem {
                Image(systemName: "star")
                Text("One")
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
