//
//  QuestApp.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//

import SwiftUI

@main
struct QuestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
