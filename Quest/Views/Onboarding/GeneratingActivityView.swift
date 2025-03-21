//
//  GeneratingActivityView.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//


import SwiftUI

struct GeneratingActivityView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Select Your Primary Generating Activity")
                .font(ThemeManager.medievalTitle())
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Choose the ONE activity that will bring in most of your new leads")
                .font(ThemeManager.medievalBody())
                .multilineTextAlignment(.center)
                .foregroundColor(ThemeManager.textSecondary)
                .padding(.horizontal)
            
            // Generating activities selection
            LazyVGrid(columns: [GridItem(.flexible())], spacing: 15) {
                ForEach(viewModel.generatingActivities, id: \.self) { activity in
                    GeneratingActivityCard(
                        title: activity,
                        isSelected: viewModel.selectedGeneratingActivity == activity,
                        action: {
                            viewModel.selectedGeneratingActivity = activity
                        }
                    )
                }
            }
            .padding()
            
            // Activity description
            if !viewModel.selectedGeneratingActivity.isEmpty {
                VStack(alignment: .leading, spacing: 10) {
                    Text("About this activity:")
                        .font(ThemeManager.medievalHeading())
                    
                    Text(descriptionForActivity(viewModel.selectedGeneratingActivity))
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
    
    private func descriptionForActivity(_ activity: String) -> String {
        switch activity {
        case "Door knocking":
            return "Door knocking involves visiting homes in targeted neighborhoods to introduce yourself and your services. It requires persistence and thick skin, but can lead to strong relationships and listings."
        case "Cold calling":
            return "Cold calling involves making phone calls to potential clients who aren't expecting your call. It's an efficient way to reach many prospects quickly and can lead to immediate opportunities."
        case "Open houses":
            return "Hosting open houses allows you to meet potential buyers and sellers in person. It's a great way to showcase properties while establishing yourself as a local expert."
        case "Events":
            return "Hosting events like market updates, homebuyer seminars, or community gatherings helps establish you as an authority and brings potential clients to you in a relaxed setting."
        case "Paid leads":
            return "Purchasing leads from platforms like Zillow, realtor.com, or Facebook gives you a steady stream of potentially interested clients, though conversion rates can vary significantly."
        default:
            return "Select an activity to see more information about it."
        }
    }
}

struct GeneratingActivityCard: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                // Icon based on the activity type
                Image(systemName: iconForActivity(title))
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? ThemeManager.accentColor : ThemeManager.textSecondary)
                    .frame(width: 40)
                
                Text(title)
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
    
    private func iconForActivity(_ activity: String) -> String {
        switch activity {
        case "Door knocking": return "door.left.hand.open"
        case "Cold calling": return "phone.arrow.up.right"
        case "Open houses": return "house"
        case "Events": return "calendar"
        case "Paid leads": return "dollarsign.circle"
        default: return "questionmark.circle"
        }
    }
}