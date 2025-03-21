// KingdomViewModel.swift

import Foundation
import SwiftUI

class KingdomViewModel: ObservableObject {
    @Published var kingdom: Kingdom?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    init() {
        loadKingdom()
    }
    
    func loadKingdom() {
        isLoading = true
        
        // In a real app, this would load from Firebase or another service
        // For now, we're using mock data
        kingdom = MockDataService.getMockKingdom()
        
        isLoading = false
    }
    
    // Update court task completion status
    func toggleCourtTask(id: String) {
        guard var kingdom = kingdom else { return }
        
        if let index = kingdom.court.tasks.firstIndex(where: { $0.id == id }) {
            kingdom.court.tasks[index].isCompleted.toggle()
            self.kingdom = kingdom
            
            // In a real app, you would save this to your database
        }
    }
    
    // Update farming task completion status
    func toggleFarmingTask(id: String) {
        guard var kingdom = kingdom else { return }
        
        if let index = kingdom.farming.tasks.firstIndex(where: { $0.id == id }) {
            kingdom.farming.tasks[index].isCompleted.toggle()
            self.kingdom = kingdom
            
            // In a real app, you would save this to your database
        }
    }
    
    // Update hunting task completion status
    func toggleHuntingTask(id: String) {
        guard var kingdom = kingdom else { return }
        
        if let index = kingdom.hunting.tasks.firstIndex(where: { $0.id == id }) {
            kingdom.hunting.tasks[index].isCompleted.toggle()
            self.kingdom = kingdom
            
            // In a real app, you would save this to your database
        }
    }
}
