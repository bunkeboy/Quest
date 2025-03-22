////
////  SummaryView.swift
////  Quest
////
////  Created by Ryan Bunke on 3/20/25.
////
//
//
//import SwiftUI
//
//struct SummaryView: View {
//    @ObservedObject var viewModel: OnboardingViewModel
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Your Kingdom Plan")
//                .font(ThemeManager.medievalTitle())
//                .multilineTextAlignment(.center)
//                .padding()
//            
//            Text("Here's your personalized plan to grow your real estate kingdom")
//                .font(ThemeManager.medievalBody())
//                .multilineTextAlignment(.center)
//                .foregroundColor(ThemeManager.textSecondary)
//                .padding(.horizontal)
//            
//            // Annual Goal Summary
//            VStack(alignment: .leading, spacing: 8) {
//                Text("Annual Goals")
//                    .font(ThemeManager.medievalHeading())
//                
//                HStack {
//                    VStack(alignment: .leading) {
//                        Text("GCI")
//                            .font(.caption)
//                            .foregroundColor(ThemeManager.textSecondary)
//                        Text("$\(Int(viewModel.gciGoal))")
//                            .font(.headline)
//                    }
//                    
//                    Spacer()
//                    
//                    VStack(alignment: .leading) {
//                        Text("Volume")
//                            .font(.caption)
//                            .foregroundColor(ThemeManager.textSecondary)
//                        Text("$\(Int(viewModel.volumeGoal))")
//                            .font(.headline)
//                    }
//                    
//                    Spacer()
//                    
//                    VStack(alignment: .leading) {
//                        Text("Transactions")
//                            .font(.caption)
//                            .foregroundColor(ThemeManager.textSecondary)
//                        Text("\(viewModel.transactionsGoal)")
//                            .font(.headline)
//                    }
//                }
//            }
//            .padding()
//            .background(ThemeManager.backgroundSecondary)
//            .cornerRadius(10)
//            
//            // Activity Strategy
//            VStack(alignment: .leading, spacing: 8) {
//                Text("Your Activity Strategy")
//                    .font(ThemeManager.medievalHeading())
//                
//                // Income sources
//                VStack(alignment: .leading, spacing: 4) {
//                    Text("Income Sources")
//                        .font(.subheadline)
//                        .foregroundColor(ThemeManager.textSecondary)
//                    
//                    ForEach(viewModel.selectedIncomeSources, id: \.self) { source in
//                        HStack {
//                            Image(systemName: "checkmark.circle.fill")
//                                .foregroundColor(ThemeManager.accentColor)
//                                .font(.caption)
//                            Text(source)
//                                .font(.body)
//                        }
//                    }
//                }
//                .padding(.vertical, 4)
//                
//                Divider()
//                
//                // Nurturing activities
//                VStack(alignment: .leading, spacing: 4) {
//                    Text("Nurturing Activities")
//                        .font(.subheadline)
//                        .foregroundColor(ThemeManager.textSecondary)
//                    
//                    ForEach(viewModel.selectedNurturingActivities, id: \.self) { activity in
//                        HStack {
//                            Image(systemName: "checkmark.circle.fill")
//                                .foregroundColor(ThemeManager.accentColor)
//                                .font(.caption)
//                            Text(activity)
//                                .font(.body)
//                        }
//                    }
//                }
//                .padding(.vertical, 4)
//                
//                Divider()
//                
//                // Primary generating activity
//                VStack(alignment: .leading, spacing: 4) {
//                    Text("Primary Generating Activity")
//                        .font(.subheadline)
//                        .foregroundColor(ThemeManager.textSecondary)
//                    
//                    HStack {
//                        Image(systemName: "star.fill")
//                            .foregroundColor(ThemeManager.accentColor)
//                            .font(.caption)
//                        Text(viewModel.selectedGeneratingActivity)
//                            .font(.body.bold())
//                    }
//                    
//                    Text("Skill Level: \(viewModel.skillLevel.rawValue)")
//                        .font(.caption)
//                        .foregroundColor(ThemeManager.textSecondary)
//                }
//                .padding(.vertical, 4)
//            }
//            .padding()
//            .background(ThemeManager.backgroundSecondary)
//            .cornerRadius(10)
//            
//            // Daily activity target
//            VStack(alignment: .leading, spacing: 8) {
//                Text("Your Daily Quest")
//                    .font(ThemeManager.medievalHeading())
//                
//                let leadsNeeded = calculateLeadsNeeded()
//                let contactsNeeded = calculateContactsNeeded()
//                let dailyContacts = Int(Double(contactsNeeded) / 220.0) // Assuming 220 working days
//                
//                HStack {
//                    Image(systemName: "target")
//                        .foregroundColor(ThemeManager.accentColor)
//                        .font(.title2)
//                    
//                    VStack(alignment: .leading) {
//                        Text("\(dailyContacts) \(activityName()) per day")
//                            .font(.headline)
//                            .foregroundColor(ThemeManager.textPrimary)
//                        
//                        Text("Complete this daily quest to grow your kingdom!")
//                            .font(.caption)
//                            .foregroundColor(ThemeManager.textSecondary)
//                    }
//                }
//            }
//            .padding()
//            .background(ThemeManager.backgroundSecondary)
//            .cornerRadius(10)
//            
//            // Get started button
//            Text("Ready to begin your quest?")
//                .font(.system(size: 16, weight: .medium))
//                .foregroundColor(ThemeManager.textSecondary)
//                .padding(.top)
//            
//            Spacer()
//        }
//        .padding()
//    }
//    
//    private func calculateLeadsNeeded() -> Int {
//        // Calculate leads needed based on skill level
//        let leadsPerDeal: Double
//        
//        switch viewModel.skillLevel {
//        case .beginner:
//            leadsPerDeal = 15
//        case .intermediate:
//            leadsPerDeal = 10
//        case .advanced:
//            leadsPerDeal = 5
//        }
//        
//        return Int(Double(viewModel.transactionsGoal) * leadsPerDeal)
//    }
//    
//    private func calculateContactsNeeded() -> Int {
//        let leadsNeeded = calculateLeadsNeeded()
//        let contactsPerLead: Double
//        
//        switch (viewModel.selectedGeneratingActivity, viewModel.skillLevel) {
//        case ("Cold calling", .beginner): contactsPerLead = 15
//        case ("Cold calling", .intermediate): contactsPerLead = 10
//        case ("Cold calling", .advanced): contactsPerLead = 5
//        case ("Door knocking", .beginner): contactsPerLead = 20
//        case ("Door knocking", .intermediate): contactsPerLead = 12
//        case ("Door knocking", .advanced): contactsPerLead = 7
//        case ("Open houses", .beginner): contactsPerLead = 15
//        case ("Open houses", .intermediate): contactsPerLead = 10
//        case ("Open houses", .advanced): contactsPerLead = 5
//        case ("Events", .beginner): contactsPerLead = 12
//        case ("Events", .intermediate): contactsPerLead = 8
//        case ("Events", .advanced): contactsPerLead = 4
//        case ("Paid leads", .beginner): contactsPerLead = 8
//        case ("Paid leads", .intermediate): contactsPerLead = 5
//        case ("Paid leads", .advanced): contactsPerLead = 3
//        default: contactsPerLead = 10
//        }
//        
//        return Int(Double(leadsNeeded) * contactsPerLead)
//    }
//    
//    private func activityName() -> String {
//        switch viewModel.selectedGeneratingActivity {
//        case "Cold calling": return "calls"
//        case "Door knocking": return "doors"
//        case "Open houses": return "visitors"
//        case "Events": return "attendees"
//        case "Paid leads": return "leads"
//        default: return "contacts"
//        }
//    }
//}
