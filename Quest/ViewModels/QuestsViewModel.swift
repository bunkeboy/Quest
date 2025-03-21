//
//  QuestsViewModel.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//


// QuestsViewModel.swift

import Foundation
import SwiftUI

class QuestsViewModel: ObservableObject {
    @Published var dailyQuests: [QuestModel] = []
    @Published var weeklyQuests: [QuestModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    init() {
        loadQuests()
    }
    
    func loadQuests() {
        isLoading = true
        
        // In a real app, this would load from Firebase or another service
        // For now, we're using mock data
        let allQuests = MockDataService.getMockQuests()
        
        // Filter quests by type
        dailyQuests = allQuests.filter { $0.isDaily }
        weeklyQuests = allQuests.filter { $0.isWeekly }
        
        isLoading = false
    }
    
    func completeQuest(id: String) {
        // Find and update quest in daily quests
        if let index = dailyQuests.firstIndex(where: { $0.id == id }) {
            dailyQuests[index].status = .completed
        }
        
        // Find and update quest in weekly quests
        if let index = weeklyQuests.firstIndex(where: { $0.id == id }) {
            weeklyQuests[index].status = .completed
        }
        
        // In a real app, you would save this to your database
    }
}
