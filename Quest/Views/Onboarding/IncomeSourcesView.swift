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
            Text("Select Your Income Sources")
                .font(ThemeManager.medievalTitle())
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Choose up to 3 primary sources that will feed your kingdom")
                .font(ThemeManager.medievalBody())
                .multilineTextAlignment(.center)
                .foregroundColor(ThemeManager.textSecondary)
                .padding(.horizontal)
            
            // Income source selection
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                    ForEach(viewModel.incomeSources, id: \.self) { source in
                        IncomeSourceCard(
                            title: source,
                            isSelected: viewModel.selectedIncomeSources.contains(source),
                            action: {
                                toggleSelection(source)
                            }
                        )
                    }
                }
                .padding()
            }
            
            // Selection counter
            Text("\(viewModel.selectedIncomeSources.count)/3 sources selected")
                .font(.caption)
                .foregroundColor(viewModel.selectedIncomeSources.count == 3 ? ThemeManager.successColor : ThemeManager.textSecondary)
                .padding()
            
            Spacer()
        }
        .padding()
    }
    
    private func toggleSelection(_ source: String) {
        if viewModel.selectedIncomeSources.contains(source) {
            // Remove if already selected
            viewModel.selectedIncomeSources.removeAll { $0 == source }
        } else if viewModel.selectedIncomeSources.count < 3 {
            // Add if less than 3 selected
            viewModel.selectedIncomeSources.append(source)
        }
    }
}

struct IncomeSourceCard: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                // Icon based on the source type
                Image(systemName: iconForSource(title))
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
    
    private func iconForSource(_ source: String) -> String {
        switch source {
        case "Brokerage leads": return "building.2"
        case "Sphere of influence": return "person.3"
        case "Door knocking": return "door.left.hand.open"
        case "Cold calling": return "phone.arrow.up.right"
        case "Past clients": return "person.crop.circle.badge.checkmark"
        case "Referrals": return "arrow.triangle.branch"
        default: return "questionmark.circle"
        }
    }
}