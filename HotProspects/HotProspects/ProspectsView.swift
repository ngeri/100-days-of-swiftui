//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Németh Gergely on 2019. 12. 14..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var isShowingSortOption = false
    @State var sort: SortType = .name

    enum FilterType {
        case none, contacted, uncontacted
    }

    enum SortType: String, CaseIterable {
        case name, recent
    }

    let filter: FilterType

    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        if self.filter == .none {
                            if prospect.isContacted {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.green)
                            } else {
                                Image(systemName: "questionmark.diamond")
                                    .foregroundColor(.yellow)
                            }
                        }
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted" ) {
                            self.prospects.toggle(prospect)
                        }
                        if !prospect.isContacted {
                            Button("Remind Me") {
                                self.addNotification(for: prospect)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(leading: Button(action: { self.isShowingSortOption = true }) {
                Image(systemName: "arrow.up.arrow.down")
            }, trailing: Button(action: { self.isShowingScanner = true }) {
                Image(systemName: "qrcode.viewfinder")
                Text("Scan")
            })
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: self.handleScan)
            }
            .actionSheet(isPresented: $isShowingSortOption) {
                self.actionSheet
            }
        }
    }

    var actionSheet: ActionSheet {
        ActionSheet(title: Text("Choose how to sort"), buttons:
            SortType.allCases.map { item in
                ActionSheet.Button.default(Text(item.rawValue.capitalized), action: { self.sort = item })
            }
        )
    }

    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }

    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            switch sort {
            case .name: return prospects.people.sorted(by: { $0.name < $1.name })
            case .recent: return prospects.people.sorted(by: { $0.date > $1.date })
            }
        case .contacted:
            switch sort {
            case .name: return prospects.people.filter { $0.isContacted }.sorted(by: { $0.name < $1.name })
            case .recent: return prospects.people.filter { $0.isContacted }.sorted(by: { $0.date > $1.date })
            }
        case .uncontacted:
            switch sort {
            case .name: return prospects.people.filter { !$0.isContacted }.sorted(by: { $0.name < $1.name })
            case .recent: return prospects.people.filter { !$0.isContacted }.sorted(by: { $0.date > $1.date })
            }
        }
    }

    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
       self.isShowingScanner = false
       switch result {
       case .success(let code):
           let details = code.components(separatedBy: "\n")
           guard details.count == 2 else { return }

           let person = Prospect()
           person.name = details[0]
           person.emailAddress = details[1]

           self.prospects.add(person)
       case .failure(let error):
        print("Scanning failed with \(error.localizedDescription)")
       }
    }

    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

            var dateComponents = DateComponents()
            dateComponents.hour = 9
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(Prospects())
    }
}
