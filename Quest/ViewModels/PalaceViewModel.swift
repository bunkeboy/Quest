//
//  PalaceViewModel.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//


// PalaceViewModel.swift

import Foundation
import SwiftUI

class PalaceViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    init() {
        loadUser()
    }
    
    func loadUser() {
        isLoading = true
        
        // In a real app, this would load from Firebase or another service
        // For now, we're using mock data
        user = MockDataService.getMockUser()
        
        isLoading = false
    }
    
    // List of available features (some locked)
    var palaceFeatures: [(title: String, icon: String, isLocked: Bool)] {
        return [
            ("Items", "backpack.fill", false),
            ("Forge", "hammer.fill", true),
            ("Stable", "hare.fill", true),
            ("Throne Room", "crown.fill", false)
        ]
    }
    
    // Calculate XP needed for next level
    func xpForNextLevel() -> Int {
        guard let user = user else { return 500 }
        
        // Simple formula: 500 XP for level 1, +250 per additional level
        return 500 + (user.level - 1) * 250
    }
    
    // Progress toward next level (0.0 to 1.0)
    func levelProgress() -> Double {
        guard let user = user else { return 0.0 }
        
        let nextLevelXP = xpForNextLevel()
        return Double(user.stats.xpPoints) / Double(nextLevelXP)
    }
}
