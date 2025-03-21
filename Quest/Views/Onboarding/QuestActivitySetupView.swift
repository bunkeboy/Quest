//
//  QuestActivitySetupView.swift
//  Quest
//
//  Created by Ryan Bunke on 3/21/25.
//


//
//  QuestActivitySetupView.swift
//  Quest
//

import SwiftUI

struct QuestActivitySetupView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create a Quest Activity")
                .font(ThemeManager.medievalTitle())
                .multilineTextAlignment(.center)
                .padding()
            
            // Business source selection
            VStack(alignment: .leading) {
                Text("Select Business Source")
                    .font(ThemeManager.medievalHeading())
                
                Picker("Business Source", selection: $viewModel.currentSource) {
                    ForEach(BusinessSource.allCases) { source in
                        Text(source.rawValue).tag(source)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical, 5)
            }
            .padding()
            .background(ThemeManager.backgroundSecondary)
            .cornerRadius(10)
            
            // Business percentage slider
            VStack(alignment: .leading) {
                Text("Percentage of Business")
                    .font(ThemeManager.medievalHeading())
                
                Text("\(Int(viewModel.businessPercentage))%")
                    .font(.title2.bold())
                    .foregroundColor(ThemeManager.accentColor)
                
                Slider(value: $viewModel.businessPercentage, in: 10...100, step: 10)
                    .accentColor(ThemeManager.accentColor)
            }
            .padding()
            .background(ThemeManager.backgroundSecondary)
            .cornerRadius(10)
            
            // Activity selection
            VStack(alignment: .leading) {
                Text("Select Nurturing Activity")
                    .font(ThemeManager.medievalHeading())
                
                Picker("Nurturing Activity", selection: $viewModel.currentActivity) {
                    ForEach(NurturingActivity.allCases) { activity in
                        Text(activity.rawValue).tag(activity)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 100)
            }
            .padding()
            .background(ThemeManager.backgroundSecondary)
            .cornerRadius(10)
            
            // Ratio sliders
            VStack(alignment: .leading) {
                Text("Set Conversion Ratios")
                    .font(ThemeManager.medievalHeading())
                
                HStack {
                    Text("Leads to Prospect:")
                        .font(.caption)
                    Spacer()
                    Text("1:\(Int(viewModel.leadsToProspectRatio))")
                        .font(.headline)
                }
                
                Slider(value: $viewModel.leadsToProspectRatio, in: 2...20, step: 1)
                    .accentColor(ThemeManager.accentColor)
                
                HStack {
                    Text("Prospect to Sale:")
                        .font(.caption)
                    Spacer()
                    Text("1:\(Int(viewModel.prospectToSaleRatio))")
                        .font(.headline)
                }
                
                Slider(value: $viewModel.prospectToSaleRatio, in: 2...20, step: 1)
                    .accentColor(ThemeManager.accentColor)
            }
            .padding()
            .background(ThemeManager.backgroundSecondary)
            .cornerRadius(10)
            
            // Calculate and show activity count
            Button(action: {
                viewModel.calculateActivityCount()
                viewModel.createActivityTile()
                viewModel.currentStep = 9 // Go back to cadence view
            }) {
                Text("Create Activity Tile")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(ThemeManager.secondaryColor)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
        }
        .padding()
    }
}
