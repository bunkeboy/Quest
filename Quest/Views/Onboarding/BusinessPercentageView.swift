//
//  BusinessPercentageView.swift
//  Quest
//
//  Created by Ryan Bunke on 3/21/25.
//


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
