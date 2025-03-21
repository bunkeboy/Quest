//
//  SkillAssessmentView.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//


import SwiftUI

struct SkillAssessmentView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Rate Your Skill Level")
                .font(ThemeManager.medievalTitle())
                .multilineTextAlignment(.center)
                .padding()
            
            if viewModel.selectedGeneratingActivity.isEmpty {
                Text("Please select a generating activity first")
                    .font(ThemeManager.medievalBody())
                    .foregroundColor(ThemeManager.errorColor)
            } else {
                Text("How would you rate your skill with \(viewModel.selectedGeneratingActivity)?")
                    .font(ThemeManager.medievalBody())
                    .multilineTextAlignment(.center)
                    .foregroundColor(ThemeManager.textSecondary)
                    .padding(.horizontal)
                
                // Skill level selection
                VStack(spacing: 15) {
                    ForEach(OnboardingViewModel.SkillLevel.allCases) { level in
                        SkillLevelCard(
                            level: level,
                            selectedActivity: viewModel.selectedGeneratingActivity,
                            isSelected: viewModel.skillLevel == level,
                            action: {
                                viewModel.skillLevel = level
                            }
                        )
                    }
                }
                .padding()
                
                // Activity description
                VStack(alignment: .leading, spacing: 10) {
                    Text("What this means:")
                        .font(ThemeManager.medievalHeading())
                    
                    Text("With your current skill level, you'll need to focus on consistent daily activities to reach your goals. The next screen will show your personalized formula for success.")
                        .font(ThemeManager.medievalBody())
                        .foregroundColor(ThemeManager.textSecondary)
                }
                .padding()
                .background(ThemeManager.backgroundSecondary)
                .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct SkillLevelCard: View {
    let level: OnboardingViewModel.SkillLevel
    let selectedActivity: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(level.rawValue)
                        .font(.headline)
                        .foregroundColor(isSelected ? ThemeManager.accentColor : ThemeManager.textPrimary)
                    
                    Spacer()
                    
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(ThemeManager.accentColor)
                    }
                }
                
                Divider()
                
                // Conversion rates based on activity and skill level
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("Contact to Lead:")
                            .font(.caption)
                            .foregroundColor(ThemeManager.textSecondary)
                        Text(contactToLeadRatio())
                            .font(.system(size: 14, weight: .bold))
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("Lead to Sale:")
                            .font(.caption)
                            .foregroundColor(ThemeManager.textSecondary)
                        Text(leadToSaleRatio())
                            .font(.system(size: 14, weight: .bold))
                    }
                }
            }
            .padding()
            .background(isSelected ? ThemeManager.backgroundSecondary : ThemeManager.backgroundPrimary.opacity(0.5))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? ThemeManager.accentColor : ThemeManager.textSecondary.opacity(0.3), lineWidth: isSelected ? 2 : 1)
            )
        }
    }
    
    private func contactToLeadRatio() -> String {
        switch (selectedActivity, level) {
        case ("Cold calling", .beginner): return "15 calls → 1 lead"
        case ("Cold calling", .intermediate): return "10 calls → 1 lead"
        case ("Cold calling", .advanced): return "5 calls → 1 lead"
        case ("Door knocking", .beginner): return "20 doors → 1 lead"
        case ("Door knocking", .intermediate): return "12 doors → 1 lead"
        case ("Door knocking", .advanced): return "7 doors → 1 lead"
        case ("Open houses", .beginner): return "15 visitors → 1 lead"
        case ("Open houses", .intermediate): return "10 visitors → 1 lead"
        case ("Open houses", .advanced): return "5 visitors → 1 lead"
        case ("Events", .beginner): return "12 attendees → 1 lead"
        case ("Events", .intermediate): return "8 attendees → 1 lead"
        case ("Events", .advanced): return "4 attendees → 1 lead"
        case ("Paid leads", .beginner): return "8 leads → 1 qualified"
        case ("Paid leads", .intermediate): return "5 leads → 1 qualified"
        case ("Paid leads", .advanced): return "3 leads → 1 qualified"
        default: return "N/A"
        }
    }
    
    private func leadToSaleRatio() -> String {
        switch level {
        case .beginner: return "15 leads → 1 sale"
        case .intermediate: return "10 leads → 1 sale"
        case .advanced: return "5 leads → 1 sale"
        }
    }
}