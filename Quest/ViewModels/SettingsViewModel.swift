//
//  SettingsViewModel.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//


// SettingsViewModel.swift

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var user: User?
    @Published var notificationsEnabled = true
    @Published var soundEnabled = true
    @Published var themePreference: ThemePreference = .light
    @Published var isCRMConnected = false
    @Published var isLoading = false
    
    init() {
        loadUserSettings()
    }
    
    func loadUserSettings() {
        isLoading = true
        
        // In a real app, this would load from Firebase or another service
        // For now, we're using mock data
        user = MockDataService.getMockUser()
        
        // Set view model state from user settings
        if let user = user {
            notificationsEnabled = user.settings.notificationsEnabled
            soundEnabled = user.settings.soundEnabled
            themePreference = user.settings.themePreference
        }
        
        isLoading = false
    }
    
    func saveUserSettings() {
        // In a real app, this would save to Firebase or another service
        print("Saving user settings:")
        print("Notifications: \(notificationsEnabled)")
        print("Sound: \(soundEnabled)")
        print("Theme: \(themePreference)")
        
        // In a real app, you would save this to your database
    }
    
    func connectCRM() {
        // In a real app, this would connect to Follow Up Boss
        isCRMConnected = true
        
        // In a real app, you would save this to your database
    }
    
    func disconnectCRM() {
        // In a real app, this would disconnect from Follow Up Boss
        isCRMConnected = false
        
        // In a real app, you would save this to your database
    }
}
