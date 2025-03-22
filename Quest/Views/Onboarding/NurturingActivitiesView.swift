//
//  NurturingActivitiesView.swift
//  Quest
//

import SwiftUI

struct NurturingActivitiesView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Select a Nurturing Activity")
                .font(ThemeManager.medievalTitle())
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Choose one way you'll nurture your relationships")
                .font(ThemeManager.medievalBody())
                .multilineTextAlignment(.center)
                .foregroundColor(ThemeManager.textSecondary)
                .padding(.horizontal)
            
            // Nurturing activities selection
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(NurturingActivity.allCases) { activity in
                        NurturingActivityCard(
                            activity: activity,
                            isSelected: viewModel.currentActivity == activity,
                            action: {
                                // Set the selected activity
                                viewModel.currentActivity = activity
                                
                                // Auto-advance to conversion ratios
                                viewModel.currentStep = 6
                            }
                        )
                    }
                }
                .padding()
            }
            
            Spacer()
            
        }
        .padding()
    }
}

// Card for each nurturing activity
struct NurturingActivityCard: View {
    let activity: NurturingActivity
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                // Icon based on the activity type
                Image(systemName: iconForActivity(activity))
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? ThemeManager.accentColor : ThemeManager.textSecondary)
                    .frame(width: 40)
                
                Text(activity.rawValue)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(isSelected ? ThemeManager.textPrimary : ThemeManager.textSecondary)
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(ThemeManager.accentColor)
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
    
    private func iconForActivity(_ activity: NurturingActivity) -> String {
        switch activity {
        case .phoneCalls: return "phone.fill"
        case .doorknocking: return "door.left.hand.open"
        case .newsletters: return "newspaper.fill"
        case .events: return "calendar"
        case .socialMedia: return "network"
        case .directMail: return "envelope.fill"
        case .gifts: return "gift.fill"
        case .other: return "ellipsis.circle.fill"
        }
    }
}
