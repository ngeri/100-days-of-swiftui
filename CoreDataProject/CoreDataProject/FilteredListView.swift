//
//  FilteredListView.swift
//  CoreDataProject
//
//  Created by Németh Gergely on 2019. 11. 20..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var items: FetchedResults<T> { fetchRequest.wrappedValue }
    
    let content: (T) -> Content

    var body: some View {
        List(items, id: \.self) { item in
            self.content(item)
        }
    }

    init(predicate: NSPredicate?, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: predicate)
        self.content = content
    }
}
