//
//  Lotus_TimerApp.swift
//  Lotus Timer
//
//  Created by Joel Groomer on 11/25/20.
//

import SwiftUI

@main
struct Lotus_TimerApp: App {
    @StateObject var dataController: DataController
    
    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
                .onReceive(NotificationCenter.default.publisher(
                            for: UIApplication.willResignActiveNotification),   // when app goes into background
                           perform: save)                                       // save data so it's not lost
        }
    }
    
    func save(_ note: Notification) {
        dataController.save()
    }
}
