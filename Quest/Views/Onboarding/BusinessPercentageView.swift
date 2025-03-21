//
//  BusinessPercentageView.swift
//  Quest
//

import SwiftUI

struct BusinessPercentageView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 25) {
            // Header
            Text("Allocate Business Percentage")
                .font(ThemeManager.medievalTitle())
                .foregroundColor(ThemeManager.textPrimary)
            
            // Explanation
            Text("What percentage of your \(goalTypeText(viewModel.goalType)) will come from \(viewModel.currentSource.rawValue) via \(viewModel.currentActivity.rawValue)?")
                .font(ThemeManager.medievalBody())
                .multilineTextAlignment(.center)
                .foregroundColor(ThemeManager.textSecondary)
                .padding(.horizontal)
            
            // Business percentage slider
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Business Percentage:")
                        .font(ThemeManager.medievalHeading())
                    
                    Spacer()
                    
                    Text("\(Int(viewModel.businessPercentage))%")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(ThemeManager.accentColor)
                }
                
                Slider(value: $viewModel.businessPercentage, in: 10...100, step: 10)
                    .accentColor(ThemeManager.accentColor)
                
                // Slider labels
                HStack {
                    Text("10%")
                        .font(.caption2)
                        .foregroundColor(ThemeManager.textSecondary)
                    
                    Spacer()
                    
                    Text("100%")
                        .font(.caption2)
                        .foregroundColor(ThemeManager.textSecondary)
                }
            }
            .padding()
            .background(ThemeManager.backgroundSecondary)
            .cornerRadius(12)
            .padding(.horizontal)
            
            Spacer()
            
            // Navigation buttons
            HStack {
                // Back button
                Button(action: {
                    viewModel.currentStep = 5 // Go back to activity selection
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                        Text("Back")
                    }
                    .foregroundColor(ThemeManager.secondaryColor)
                    .padding()
                }
                
                Spacer()
                
                // Next button
                Button(action: {
                    viewModel.currentStep = 7 // Go to conversion ratios
                }) {
                    HStack {
                        Text("Next")
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(ThemeManager.secondaryColor)
                    .cornerRadius(8)
                }
            }
            .padding()
        }
        .padding()
    }
    
    // Helper to get text based on goal type
    private func goalTypeText(_ type: GoalType) -> String {
        switch type {
        case .commission:
            return "commission income"
        case .deals:
            return "deals"
        case .volume:
            return "sales volume"
        }
    }
}