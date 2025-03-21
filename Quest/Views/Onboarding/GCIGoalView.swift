//
//  GCIGoalView.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//


import SwiftUI

struct GCIGoalView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Set Your Annual GCI Goal")
                .font(ThemeManager.medievalTitle())
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Gross Commission Income (GCI) is the total commission you expect to earn this year")
                .font(ThemeManager.medievalBody())
                .multilineTextAlignment(.center)
                .foregroundColor(ThemeManager.textSecondary)
                .padding(.horizontal)
            
            // Slider for GCI goal
            VStack {
                Text("$\(Int(viewModel.gciGoal))")
                    .font(.title)
                    .fontWeight(.bold)
                
                Slider(value: $viewModel.gciGoal, in: 50000...500000, step: 10000)
                    .padding(.horizontal)
                
                HStack {
                    Text("$50,000")
                        .font(.caption)
                    Spacer()
                    Text("$500,000")
                        .font(.caption)
                }
                .padding(.horizontal)
            }
            .padding()
            .background(ThemeManager.backgroundSecondary)
            .cornerRadius(10)
            
            // Comparison to average
            VStack(alignment: .leading, spacing: 10) {
                Text("How this compares:")
                    .font(ThemeManager.medievalHeading())
                
                HStack {
                    Text("Novice Squire:")
                        .foregroundColor(ThemeManager.textSecondary)
                    Spacer()
                    Text("$50,000 - $100,000")
                }
                
                HStack {
                    Text("Knight:")
                        .foregroundColor(ThemeManager.textSecondary)
                    Spacer()
                    Text("$100,000 - $200,000")
                }
                
                HStack {
                    Text("Lord/Baron:")
                        .foregroundColor(ThemeManager.textSecondary)
                    Spacer()
                    Text("$200,000 - $300,000")
                }
                
                HStack {
                    Text("Duke/Royalty:")
                        .foregroundColor(ThemeManager.textSecondary)
                    Spacer()
                    Text("$300,000+")
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