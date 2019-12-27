//
//  ResultsView.swift
//  Dice
//
//  Created by Gergely Németh on 2019. 12. 27..
//  Copyright © 2019. Gergely Németh. All rights reserved.
//

import CoreData
import SwiftUI

struct ResultsView: View {
    @FetchRequest(entity: Roll.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Roll.date, ascending: false)])
    var rolls: FetchedResults<Roll>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(rolls, id: \.rollDate) { roll in
                    HStack {
                        Image(systemName: "\(roll.rollValue).circle")
                        Text("out of")
                        Image(systemName: "\(roll.rollMaxValue).circle")
                    }
                }
            }
            .navigationBarTitle("Results")
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
