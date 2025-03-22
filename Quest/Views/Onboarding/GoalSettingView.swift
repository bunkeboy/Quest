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
                // Replace the Picker with these buttons
                HStack(spacing: 10) {
                    ForEach(GoalType.allCases) { type in
                        Button(action: {
                            viewModel.goalType = type
                        }) {
                            VStack {
                                Text(type.rawValue)
                                    .font(.system(size: 14, weight: .medium))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(viewModel.goalType == type ? ThemeManager.textPrimary : ThemeManager.textSecondary)
                            }
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .padding(8)
                            .background(viewModel.goalType == type ? ThemeManager.backgroundSecondary : ThemeManager.backgroundPrimary.opacity(0.5))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(viewModel.goalType == type ? ThemeManager.accentColor : ThemeManager.textSecondary.opacity(0.3), lineWidth: viewModel.goalType == type ? 2 : 1)
                            )
                        }
                    }
                }
                .padding(.vertical)
            }
            .padding()
            .background(ThemeManager.backgroundSecondary)
            .cornerRadius(12)
            .padding(.horizontal)
            
            // Goal value slider based on type
            VStack(alignment: .leading, spacing: 10) {
                Text("Set your target \(goalTypeText(viewModel.goalType))")
                    .font(ThemeManager.medievalHeading())
                    .foregroundColor(ThemeManager.textPrimary)
                
                // Show current value
                HStack {

                    
                    Text(formattedValue())
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(ThemeManager.textPrimary)
                }
                .padding(.vertical, 5)
                
                // Different slider based on goal type
                switch viewModel.goalType {
                case .commission:
                    // Commission slider ($0 - $500K in $50K increments)
                    Slider(value: $viewModel.goalValue, in: 0...500000, step: 50000)
                        .accentColor(ThemeManager.accentColor)
                    
                    // Slider labels
                    HStack {
                        Text("$0")
                            .font(.caption2)
                            .foregroundColor(ThemeManager.textSecondary)
                        
                        Spacer()
                        
                        Text("$500K")
                            .font(.caption2)
                            .foregroundColor(ThemeManager.textSecondary)
                    }
                    
                case .deals:
                    // Deals slider (0-50 in increments of 1)
                    Slider(value: $viewModel.goalValue, in: 0...50, step: 1)
                        .accentColor(ThemeManager.accentColor)
                    
                    // Slider labels
                    HStack {
                        Text("0")
                            .font(.caption2)
                            .foregroundColor(ThemeManager.textSecondary)
                        
                        Spacer()
                        
                        Text("50")
                            .font(.caption2)
                            .foregroundColor(ThemeManager.textSecondary)
                    }
                    
                case .volume:
                    // Volume slider ($0 - $20M in $250K increments)
                    Slider(value: $viewModel.goalValue, in: 0...20000000, step: 250000)
                        .accentColor(ThemeManager.accentColor)
                    
                    // Slider labels
                    HStack {
                        Text("$0")
                            .font(.caption2)
                            .foregroundColor(ThemeManager.textSecondary)
                        
                        Spacer()
                        
                        Text("$20M")
                            .font(.caption2)
                            .foregroundColor(ThemeManager.textSecondary)
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
            
            // Timeline selection with wheel picker
            VStack(alignment: .leading, spacing: 10) {
                Text("Timeline")
                    .font(ThemeManager.medievalHeading())
                    .foregroundColor(ThemeManager.textPrimary)
                
                // Wheel picker for months (3-12)
                HStack {
                    Spacer()
                    
                    Picker("Timeline", selection: $viewModel.timelineMonths) {
                        ForEach(3...12, id: \.self) { month in
                            Text("\(month) months").tag(month)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 200, height: 80)
                    
                    Spacer()
                }
            }
            .padding()
            .background(ThemeManager.backgroundSecondary)
            .cornerRadius(12)
            .padding(.horizontal)
            

        }
        .padding(.vertical, 15)
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
    
    // Format the current value based on type
    private func formattedValue() -> String {
        switch viewModel.goalType {
        case .commission:
            // Format as currency
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 0
            return formatter.string(from: NSNumber(value: viewModel.goalValue)) ?? "$0"
            
        case .deals:
            // Format as integer
            return "\(Int(viewModel.goalValue)) Deals"
            
        case .volume:
            // Format as currency with possible M/K suffix
            if viewModel.goalValue >= 1_000_000 {
                return String(format: "$%.1fM", viewModel.goalValue / 1_000_000)
            } else if viewModel.goalValue >= 1_000 {
                return String(format: "$%.0fK", viewModel.goalValue / 1_000)
            } else {
                return "$\(Int(viewModel.goalValue))"
            }
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
