//
//  QuestApp.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//

// QuestApp.swift

import SwiftUI

@main
struct QuestApp: App {
    @AppStorage("onboardingComplete") var onboardingComplete: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if onboardingComplete {
                MainTabView()
            } else {
                OnboardingView()
            }
        }
    }
}
