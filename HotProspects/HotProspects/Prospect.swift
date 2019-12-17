//
//  Prospect.swift
//  HotProspects
//
//  Created by Németh Gergely on 2019. 12. 14..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    let id = UUID()
    let date = Date()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    static let saveKey = "SavedData"
    @Published private(set) var people: [Prospect]

    init() {
        let filename = FileManager.default.documentsURL.appendingPathComponent(Self.saveKey)

        do {
            let data = try Data(contentsOf: filename)
            let decoded = try JSONDecoder().decode([Prospect].self, from: data)
            self.people = decoded
        } catch {
            self.people = []
        }
    }

    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }

    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }

    private func save() {
        do {
            let filename = FileManager.default.documentsURL.appendingPathComponent(Self.saveKey)
            let data = try JSONEncoder().encode(people)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}

private extension FileManager {
    var documentsURL: URL {
        urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
