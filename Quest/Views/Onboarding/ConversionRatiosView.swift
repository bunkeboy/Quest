//
//  ConversionRatiosView.swift
//  Quest
//
//  Created by Ryan Bunke on 3/21/25.
//


//
//  ConversionRatiosView.swift
//  Quest
//

import SwiftUI

struct ConversionRatiosView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 25) {
            // Header
            Text("Set Conversion Ratios")
                .font(ThemeManager.medievalTitle())
                .foregroundColor(ThemeManager.textPrimary)
            
            // Ratio sliders
            VStack(alignment: .leading, spacing: 16) {
                Text("For each ratio, how many leads do you need?")
                    .font(ThemeManager.medievalBody())
                    .foregroundColor(ThemeManager.textSecondary)
                
                // Leads to Prospect ratio
                VStack(alignment: .leading, spacing: 8) {
                    Text("Leads to Prospect Ratio:")
                        .font(ThemeManager.medievalHeading())
                        .foregroundColor(ThemeManager.textPrimary)
                    
                    HStack {
                        Text("\(Int(viewModel.leadsToProspectRatio)):1")
                            .font(.headline)
                            .foregroundColor(ThemeManager.accentColor)
                        
                        Spacer()
                    }
                    
                    Slider(value: $viewModel.leadsToProspectRatio, in: 2...20, step: 1)
                        .accentColor(ThemeManager.accentColor)
                }
                .padding()
                .background(ThemeManager.backgroundSecondary)
                .cornerRadius(10)
                
                // Prospect to Sale ratio
                VStack(alignment: .leading, spacing: 8) {
                    Text("Prospect to Sale Ratio:")
                        .font(ThemeManager.medievalHeading())
                        .foregroundColor(ThemeManager.textPrimary)
                    
                    HStack {
                        Text("\(Int(viewModel.prospectToSaleRatio)):1")
                            .font(.headline)
                            .foregroundColor(ThemeManager.accentColor)
                        
                        Spacer()
                    }
                    
                    Slider(value: $viewModel.prospectToSaleRatio, in: 2...20, step: 1)
                        .accentColor(ThemeManager.accentColor)
                }
                .padding()
                .background(ThemeManager.backgroundSecondary)
                .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Spacer()
            
            
            // Create Quest button
            Button(action: {
                // Calculate activities needed
                let businessFraction = viewModel.businessPercentage / 100.0
                let prospectLeadFraction = 1.0 / viewModel.leadsToProspectRatio
                let saleProspectFraction = 1.0 / viewModel.prospectToSaleRatio
                
                // Use goalValue for calculation
                let activityCount = viewModel.goalValue * businessFraction * prospectLeadFraction * saleProspectFraction
                viewModel.calculatedActivityCount = Int(activityCount.rounded())
                
                // Create the tile
                viewModel.createActivityTile()
                
                // Return to Quest Manager
                viewModel.currentStep = 3
            }) {
                Text("Create Quest")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(ThemeManager.secondaryColor)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .padding()
    }
}
