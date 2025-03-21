//
//  GoalSettingView.swift
//  Quest
//
//  Created by Ryan Bunke on 3/21/25.
//


//
//  GoalSettingView.swift
//  Quest
//

import SwiftUI

struct GoalSettingView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    // Add these properties to OnboardingViewModel
    // @Published var goalType: GoalType = .commission
    // @Published var goalValue: Double = 300000
    
    // Formatter for currency input
    private let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 25) {
            // Header
            Text("Set Your Target Goal")
                .font(ThemeManager.medievalTitle())
                .foregroundColor(ThemeManager.textPrimary)
            
            // Goal type selection
            VStack(alignment: .leading, spacing: 10) {
                Text("What would you like to track?")
                    .font(ThemeManager.medievalHeading())
                    .foregroundColor(ThemeManager.textPrimary)
                
                Picker("Goal Type", selection: $viewModel.goalType) {
                    Text("Commission Income").tag(GoalType.commission)
                    Text("Deals Closed").tag(GoalType.deals)
                    Text("Deal Volume").tag(GoalType.volume)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical, 5)
            }
            .padding()
            .background(ThemeManager.backgroundSecondary)
            .cornerRadius(12)
            .padding(.horizontal)
            
            // Goal value input
            VStack(alignment: .leading, spacing: 10) {
                Text("Set your target \(goalTypeText(viewModel.goalType))")
                    .font(ThemeManager.medievalHeading())
                    .foregroundColor(ThemeManager.textPrimary)
                
                // Different input type based on goal type
                if viewModel.goalType == .deals {
                    // Number input for deals
                    Stepper("\(Int(viewModel.goalValue)) Deals", value: $viewModel.goalValue, in: 1...200, step: 1)
                        .padding()
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(8)
                } else {
                    // Currency input for commission and volume
                    HStack {
                        Text("$")
                            .font(.title2)
                            .foregroundColor(ThemeManager.textPrimary)
                        
                        TextField(viewModel.goalType == .commission ? "300,000" : "20,000,000", 
                                 value: $viewModel.goalValue, 
                                 formatter: currencyFormatter)
                            .font(.title2)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(8)
                    }
                }
                
                // Goal context explanation
                Text(goalContextText(viewModel.goalType, value: viewModel.goalValue))
                    .font(.caption)
                    .foregroundColor(ThemeManager.textSecondary)
                    .padding(.top, 8)
            }
            .padding()
            .background(ThemeManager.backgroundSecondary)
            .cornerRadius(12)
            .padding(.horizontal)
            
            // Timeline selection
            VStack(alignment: .leading, spacing: 10) {
                Text("Timeline")
                    .font(ThemeManager.medievalHeading())
                    .foregroundColor(ThemeManager.textPrimary)
                
                Picker("Timeline", selection: $viewModel.timelineMonths) {
                    Text("3 months").tag(3)
                    Text("6 months").tag(6)
                    Text("12 months").tag(12)
                    Text("18 months").tag(18)
                    Text("24 months").tag(24)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical, 5)
            }
            .padding()
            .background(ThemeManager.backgroundSecondary)
            .cornerRadius(12)
            .padding(.horizontal)
            
            Spacer()
        }
        .padding(.vertical, 30)
    }
    
    // Helper to get text based on goal type
    private func goalTypeText(_ type: GoalType) -> String {
        switch type {
        case .commission:
            return "income"
        case .deals:
            return "number of deals"
        case .volume:
            return "sales volume"
        }
    }
    
    // Contextual help text based on goal type and value
    private func goalContextText(_ type: GoalType, value: Double) -> String {
        switch type {
        case .commission:
            if value < 100000 {
                return "This would be suitable for a newer agent or part-time role."
            } else if value < 300000 {
                return "This is a solid goal for an experienced full-time agent."
            } else {
                return "You're aiming high! This would typically require a team or high-volume approach."
            }
        case .deals:
            if value < 12 {
                return "This is about 1 deal per month, suitable for newer agents."
            } else if value < 30 {
                return "This is a solid production level for an experienced agent."
            } else {
                return "This high volume would typically require a team approach."
            }
        case .volume:
            if value < 5000000 {
                return "This is a reasonable goal for a newer agent or lower-priced market."
            } else if value < 15000000 {
                return "This is solid production for an experienced agent."
            } else {
                return "This high volume would typically require a team or luxury market focus."
            }
        }
    }
}
