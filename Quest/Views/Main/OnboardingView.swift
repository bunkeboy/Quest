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
                    GCIGoalView(viewModel: viewModel)
                case 2:
                    VolumeGoalView(viewModel: viewModel)
                case 3:
                    TransactionsGoalView(viewModel: viewModel)
                case 4:
                    IncomeSourcesView(viewModel: viewModel)
                case 5:
                    NurturingActivitiesView(viewModel: viewModel)
                case 6:
                    GeneratingActivityView(viewModel: viewModel)
                case 7:
                    SkillAssessmentView(viewModel: viewModel)
                case 8:
                    ActivityPlanView(viewModel: viewModel)
                case 9:
                    SummaryView(viewModel: viewModel)
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
                    
                    if viewModel.currentStep < 9 {
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
                    } else {
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
            .navigationTitle("Kingdom Setup \(viewModel.currentStep)/9")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
