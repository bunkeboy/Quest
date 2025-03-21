//
//  VolumeGoalView.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//


import SwiftUI

struct VolumeGoalView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var volumeString: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Set Your Volume Sold Goal")
                .font(ThemeManager.medievalTitle())
                .multilineTextAlignment(.center)
                .padding()
            
            Text("The total dollar amount of real estate you aim to sell this year")
                .font(ThemeManager.medievalBody())
                .multilineTextAlignment(.center)
                .foregroundColor(ThemeManager.textSecondary)
                .padding(.horizontal)
            
            // Volume input
            VStack {
                TextField("Enter goal amount", text: $volumeString)
                    .keyboardType(.numberPad)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
                    .onChange(of: volumeString) { newValue in
                        if let newAmount = Double(newValue.filter { "0123456789".contains($0) }) {
                            viewModel.volumeGoal = newAmount
                        }
                    }
                    .onAppear {
                        volumeString = "\(Int(viewModel.volumeGoal))"
                    }
                
                Text("$\(Int(viewModel.volumeGoal))")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding()
            .background(ThemeManager.backgroundSecondary)
            .cornerRadius(10)
            
            // GCI calculation
            VStack(alignment: .leading, spacing: 10) {
                Text("Estimated GCI from this volume:")
                    .font(ThemeManager.medievalHeading())
                
                // Assuming 3% commission rate
                let estimatedGCI = viewModel.volumeGoal * 0.03
                
                HStack {
                    Text("At 3% commission rate:")
                        .foregroundColor(ThemeManager.textSecondary)
                    Spacer()
                    Text("$\(Int(estimatedGCI))")
                        .fontWeight(.bold)
                }
                
                // Check if this aligns with GCI goal
                let difference = abs(estimatedGCI - viewModel.gciGoal)
                let percentDiff = (difference / viewModel.gciGoal) * 100
                
                if percentDiff > 20 {
                    Text("This volume may not align with your GCI goal")
                        .foregroundColor(ThemeManager.errorColor)
                        .font(.caption)
                        .padding(.top, 5)
                } else {
                    Text("This volume aligns with your GCI goal")
                        .foregroundColor(ThemeManager.successColor)
                        .font(.caption)
                        .padding(.top, 5)
                }
            }
            .padding()
            .background(ThemeManager.backgroundSecondary)
            .cornerRadius(10)
            
            Spacer()
        }
        .padding()
    }
}