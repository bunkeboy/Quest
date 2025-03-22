//
//  OnboardingView.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//


import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @Environment(\.dismiss) private var dismiss
    @AppStorage("onboardingComplete") var onboardingComplete: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Content changes based on current step
                switch viewModel.currentStep {
                case 1:
                    WelcomeView(viewModel: viewModel)
                case 2:
                    GoalSettingView(viewModel: viewModel)
                case 3:
                    QuestCadenceView(viewModel: viewModel)
                case 4:
                    IncomeSourcesView(viewModel: viewModel)
                case 5:
                    NurturingActivitiesView(viewModel: viewModel)
                case 6:
                    BusinessPercentageView(viewModel: viewModel)
                case 7:
                    ConversionRatiosView(viewModel: viewModel)
                default:
                    Text("Unknown step")
                }
                
                // Navigation buttons
                HStack {
                    if viewModel.currentStep > 1 {
                        Button(action: {
                            viewModel.previousStep()
                        }) {
                            HStack {
                                Image(systemName: "arrow.left")
                                Text("Back")
                            }
                            .foregroundColor(ThemeManager.secondaryColor)
                            .padding()
                        }
                    } else {
                        Spacer().frame(width: 100)
                    }
                    
                    Spacer()
                    
                    // Only show Next button for appropriate steps
                    // In OnboardingView.swift, replace the Next button section with:
                    if viewModel.currentStep < 9 && ![1, 3, 4, 5, 7, 8].contains(viewModel.currentStep) {
                        // Only show Next for steps that should have it (not 3, 4, 5, or 8)
                        Button(action: {
                            viewModel.nextStep()
                        }) {
                            HStack {
                                Text("Next")
                                Image(systemName: "arrow.right")
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(ThemeManager.secondaryColor)
                            .cornerRadius(8)
                        }
                    } else if viewModel.currentStep == 9 {
                        // The Start Your Quest button for the last step
                        Button(action: {
                            viewModel.completeOnboarding()
                            onboardingComplete = true
                        }) {
                            HStack {
                                Text("Start Your Quest")
                                Image(systemName: "flag.fill")
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(ThemeManager.secondaryColor)
                            .cornerRadius(8)
                        }
                    }
                }
                .padding()
            }
            .background(ThemeManager.backgroundPrimary)
            .navigationTitle("Kingdom Setup \(viewModel.currentStep)/10")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
