//
//  IncomeSourcesView.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//


import SwiftUI

struct IncomeSourcesView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Select a Business Source")
                .font(ThemeManager.medievalTitle())
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Choose one source that will feed your kingdom")
                .font(ThemeManager.medievalBody())
                .multilineTextAlignment(.center)
                .foregroundColor(ThemeManager.textSecondary)
                .padding(.horizontal)
            
            // Income source selection
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(BusinessSource.allCases) { source in
                        BusinessSourceCard(
                            source: source,
                            isSelected: viewModel.currentSource == source,
                            action: {
                                // Set the selected source
                                viewModel.currentSource = source
                                
                                // Auto-advance to next step
                                viewModel.currentStep = 5 // Move to NurturingActivitiesView
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

// Create a nice card for each business source
struct BusinessSourceCard: View {
    let source: BusinessSource
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                // Icon based on the source type
                Image(systemName: iconForSource(source))
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? ThemeManager.accentColor : ThemeManager.textSecondary)
                    .frame(width: 40)
                
                Text(source.rawValue)
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
    
    private func iconForSource(_ source: BusinessSource) -> String {
        switch source {
        case .sourcedLeads: return "shippingbox.fill"
        case .newLeads: return "person.crop.circle.badge.plus"
        case .sphere: return "person.3.fill"
        case .pastClients: return "person.crop.circle.badge.checkmark"
        case .referrals: return "arrow.triangle.branch"
        case .other: return "ellipsis.circle.fill"
        }
    }
}
