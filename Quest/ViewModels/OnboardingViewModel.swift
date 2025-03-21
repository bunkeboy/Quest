//
//  OnboardingViewModel.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//


import Foundation
import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var currentStep: Int = 1
    @Published var gciGoal: Double = 100000
    @Published var volumeGoal: Double = 10000000
    @Published var transactionsGoal: Int = 20
    @Published var selectedIncomeSources: [String] = []
    @Published var selectedNurturingActivities: [String] = []
    @Published var selectedGeneratingActivity: String = ""
    @Published var skillLevel: SkillLevel = .beginner
    @Published var questCadence = QuestCadence()
    @Published var currentSource: BusinessSource = .newLeads
    @Published var businessPercentage: Double = 20 // Default 20%
    @Published var currentActivity: NurturingActivity = .phoneCalls
    @Published var leadsToProspectRatio: Double = 10 // Default 10:1
    @Published var prospectToSaleRatio: Double = 10 // Default 10:1
    @Published var calculatedActivityCount: Int = 0
    @Published var selectedTile: ActivityTile?
    @Published var goalType: Quest.GoalType = .commission
    @Published var goalValue: Double = 300000
    @Published var timelineMonths: Int = 12
    
    // User can select up to 3 income sources
    let incomeSources = ["Brokerage leads", "Sphere of influence", "Door knocking", 
                       "Cold calling", "Past clients", "Referrals"]
    
    // User can select up to 3 nurturing activities
    let nurturingActivities = ["Calling", "Newsletter", "Events", 
                              "Social media", "Direct mail", "Client appreciation gifts"]
    
    // User can select 1 generating activity
    let generatingActivities = ["Door knocking", "Cold calling", "Open houses", 
                               "Events", "Paid leads"]
    
    enum SkillLevel: String, CaseIterable, Identifiable {
        case beginner = "Beginner"
        case intermediate = "Intermediate"
        case advanced = "Advanced"
        
        var id: String { self.rawValue }
    }
    
    func nextStep() {
        if currentStep < 9 {
            currentStep += 1
        }
    }
    
    func previousStep() {
        if currentStep > 1 {
            currentStep -= 1
        }
    }
    
    func completeOnboarding() {
        // Save all onboarding data
        // Mark onboarding as complete
        UserDefaults.standard.set(true, forKey: "onboardingComplete")
    }
    
    func calculateActivityCount() {
        // Formula: Goal $ × Business % × Lead:Prospect % × Prospect:Sale %
        let businessFraction = businessPercentage / 100.0
        let prospectLeadFraction = 1.0 / leadsToProspectRatio
        let saleProspectFraction = 1.0 / prospectToSaleRatio
        
        let activityCount = gciGoal * businessFraction * prospectLeadFraction * saleProspectFraction
        calculatedActivityCount = Int(activityCount.rounded())
    }

    // Create a new activity tile based on current selections
    func createActivityTile() {
        let newTile = ActivityTile(
            source: currentSource,
            activity: currentActivity,
            totalCount: calculatedActivityCount,
            unallocatedCount: calculatedActivityCount
        )
        
        questCadence.activityTiles.append(newTile)
    }

    // Allocate activities to a specific cadence
    func allocateActivities(tile: ActivityTile, cadence: CadenceType, count: Int) -> Bool {
        // Find the tile in our array
        guard let index = questCadence.activityTiles.firstIndex(where: { $0.id == tile.id }) else {
            return false
        }
        
        // Make sure we're not over-allocating
        if count > questCadence.activityTiles[index].unallocatedCount {
            return false
        }
        
        // Update the allocation
        questCadence.activityTiles[index].allocations[cadence, default: 0] += count
        questCadence.activityTiles[index].unallocatedCount -= count
        
        return true
    }

    // Calculate suggested allocation for a cadence
    func suggestedAllocation(tile: ActivityTile, cadence: CadenceType) -> Int {
        switch cadence {
        case .daily:
            return tile.unallocatedCount
        case .weekly:
            return tile.unallocatedCount / 52 // Split over 52 weeks
        case .monthly:
            return tile.unallocatedCount / 12 // Split over 12 months
        case .quarterly:
            return tile.unallocatedCount / 4 // Split over 4 quarters
        case .annual:
            return tile.unallocatedCount // All in one annual event
        }
    }

    // Reset current activity selections to start a new activity
    func resetActivitySelections() {
        currentSource = .newLeads
        businessPercentage = 20
        currentActivity = .phoneCalls
        leadsToProspectRatio = 10
        prospectToSaleRatio = 10
        calculatedActivityCount = 0
    }
}
