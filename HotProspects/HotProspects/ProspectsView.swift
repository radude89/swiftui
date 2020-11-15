//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Radu Dan on 12/11/2020.
//

import SwiftUI
import CodeScanner
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var isShowingActionSheet = false
    @State private var filterByName = false
    
    let filter: FilterType
    
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
        var people = [Prospect]()
        
        switch filter {
        case .none:
            people = prospects.people
            
        case .contacted:
            people = prospects.people.filter { $0.isContacted }
            
        case .uncontacted:
            people = prospects.people.filter { !$0.isContacted }
        }
        
        if filterByName {
            people.sort(by: <)
        }
        
        return people
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            
                            Text(prospect.emailAddess)
                                .foregroundColor(.secondary)
                        }
                        
                        if filter == .none {
                            Spacer()
                            
                            Image(systemName: prospect.isContacted ? "person.crop.circle.badge.plus" : "person.crop.circle.badge.minus")
                                .foregroundColor(prospect.isContacted ? .blue : .orange)
                        }
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                            prospects.toggle(prospect)
                        }
                        
                        if !prospect.isContacted {
                            Button("Remind Me") {
                                addNotification(for: prospect)
                            }
                        }
                    }
                }
            }
            .navigationTitle(title)
            .navigationBarItems(
                leading: Button(action: {
                    isShowingActionSheet = true
                }) {
                    Text("Sort")
                    Image(systemName: "arrow.up.arrow.down")
                    
                },
                trailing: Button(action: {
                    isShowingScanner = true
                }) {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
                })
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(
                    codeTypes: [.qr],
                    simulatedData: "Paul Hudson\npaul@hackingwithswift.com",
                    completion: handleScan
                )
            }
            .actionSheet(isPresented: $isShowingActionSheet) {
                ActionSheet(
                    title: Text("Filter prospects"),
                    message: Text("How would you like to filter your prospects?"),
                    buttons: [
                        .default(
                            Text("By Name"), action: {
                                filterByName = true
                            }
                        ),
                        .default(
                            Text("By Most Recent"), action: {
                                filterByName = false
                            }
                        ),
                        .cancel(
                            Text("Cancel")
                        )
                    ]
                )
            }

        }
    }
    
    private func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddess = details[1]
            prospects.add(person)
            
        case .failure(let error):
            print("Scaning failed \(error.localizedDescription)")
        }
    }
    
    private func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddess
            content.sound = .default
            
//            var dateComponents = DateComponents()
//            dateComponents.hour = 9
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
                        print("Failed  to request authorization with error: \(error?.localizedDescription ?? "Unknown").")
                    }
                }
            }
        }
        
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
