//
//  TransactionsGoalView.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//


import SwiftUI

struct TransactionsGoalView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Set Your Transaction Goal")
                .font(ThemeManager.medievalTitle())
                .multilineTextAlignment(.center)
                .padding()
            
            Text("The number of deals you plan to close this year")
                .font(ThemeManager.medievalBody())
                .multilineTextAlignment(.center)
                .foregroundColor(ThemeManager.textSecondary)
                .padding(.horizontal)
            
            // Transaction number input
            VStack {
                Stepper("\(viewModel.transactionsGoal) Transactions", value: $viewModel.transactionsGoal, in: 1...100)
                    .padding()
                
                Text("\(viewModel.transactionsGoal)")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding()
            .background(ThemeManager.backgroundSecondary)
            .cornerRadius(10)
            
            // Average transaction value
            VStack(alignment: .leading, spacing: 10) {
                Text("Transaction Analysis:")
                    .font(ThemeManager.medievalHeading())
                
                let avgTransactionValue = viewModel.volumeGoal / Double(viewModel.transactionsGoal)
                
                HStack {
                    Text("Average transaction value:")
                        .foregroundColor(ThemeManager.textSecondary)
                    Spacer()
                    Text("$\(Int(avgTransactionValue))")
                        .fontWeight(.bold)
                }
                
                HStack {
                    Text("Average commission per transaction:")
                        .foregroundColor(ThemeManager.textSecondary)
                    Spacer()
                    // Assuming 3% commission
                    Text("$\(Int(avgTransactionValue * 0.03))")
                        .fontWeight(.bold)
                }
                
                // Verify alignment with goals
                let calculatedGCI = avgTransactionValue * 0.03 * Double(viewModel.transactionsGoal)
                let difference = abs(calculatedGCI - viewModel.gciGoal)
                let percentDiff = (difference / viewModel.gciGoal) * 100
                
                if percentDiff > 20 {
                    Text("These transactions may not align with your GCI goal")
                        .foregroundColor(ThemeManager.errorColor)
                        .font(.caption)
                        .padding(.top, 5)
                } else {
                    Text("These transactions align with your GCI goal")
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