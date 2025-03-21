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
}
