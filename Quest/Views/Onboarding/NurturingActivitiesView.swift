//
//  NurturingActivitiesView.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//


import SwiftUI

struct NurturingActivitiesView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Select Your Nurturing Activities")
                .font(ThemeManager.medievalTitle())
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Choose up to 3 ways you'll nurture your relationships")
                .font(ThemeManager.medievalBody())
                .multilineTextAlignment(.center)
                .foregroundColor(ThemeManager.textSecondary)
                .padding(.horizontal)
            
            // Nurturing activities selection
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                    ForEach(viewModel.nurturingActivities, id: \.self) { activity in
                        NurturingActivityCard(
                            title: activity,
                            isSelected: viewModel.selectedNurturingActivities.contains(activity),
                            action: {
                                toggleSelection(activity)
                            }
                        )
                    }
                }
                .padding()
            }
            
            // Selection counter
            Text("\(viewModel.selectedNurturingActivities.count)/3 activities selected")
                .font(.caption)
                .foregroundColor(viewModel.selectedNurturingActivities.count == 3 ? ThemeManager.successColor : ThemeManager.textSecondary)
                .padding()
            
            Spacer()
        }
        .padding()
    }
    
    private func toggleSelection(_ activity: String) {
        if viewModel.selectedNurturingActivities.contains(activity) {
            // Remove if already selected
            viewModel.selectedNurturingActivities.removeAll { $0 == activity }
        } else if viewModel.selectedNurturingActivities.count < 3 {
            // Add if less than 3 selected
            viewModel.selectedNurturingActivities.append(activity)
        }
    }
}

struct NurturingActivityCard: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                // Icon based on the activity type
                Image(systemName: iconForActivity(title))
                    .font(.system(size: 30))
                    .foregroundColor(isSelected ? ThemeManager.accentColor : ThemeManager.textSecondary)
                    .padding(.bottom, 5)
                
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .multilineTextAlignment(.center)
                    .foregroundColor(isSelected ? ThemeManager.textPrimary : ThemeManager.textSecondary)
            }
            .frame(height: 100)
            .frame(maxWidth: .infinity)
            .padding()
            .background(isSelected ? ThemeManager.backgroundSecondary : ThemeManager.backgroundPrimary.opacity(0.5))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? ThemeManager.accentColor : ThemeManager.textSecondary.opacity(0.3), lineWidth: isSelected ? 2 : 1)
            )
        }
    }
    
    private func iconForActivity(_ activity: String) -> String {
        switch activity {
        case "Calling": return "phone"
        case "Newsletter": return "newspaper"
        case "Events": return "calendar"
        case "Social media": return "network"
        case "Direct mail": return "envelope"
        case "Client appreciation gifts": return "gift"
        default: return "questionmark.circle"
        }
    }
}