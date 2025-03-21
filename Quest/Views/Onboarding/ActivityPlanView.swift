//
//  ActivityPlanView.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//


import SwiftUI

struct ActivityPlanView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Your Success Formula")
                .font(ThemeManager.medievalTitle())
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Based on your goals and skills, here's your personalized activity plan")
                .font(ThemeManager.medievalBody())
                .multilineTextAlignment(.center)
                .foregroundColor(ThemeManager.textSecondary)
                .padding(.horizontal)
            
            // Activity calculation
            VStack(alignment: .leading, spacing: 20) {
                // Annual goal calculation
                VStack(alignment: .leading, spacing: 5) {
                    Text("Annual Goal")
                        .font(ThemeManager.medievalHeading())
                    
                    Text("$\(Int(viewModel.gciGoal)) GCI")
                        .font(.headline)
                        .foregroundColor(ThemeManager.textPrimary)
                }
                
                // Transactions calculation
                VStack(alignment: .leading, spacing: 5) {
                    Text("Transactions Needed")
                        .font(ThemeManager.medievalHeading())
                    
                    // Using user-defined transactions
                    Text("\(viewModel.transactionsGoal) transactions")
                        .font(.headline)
                        .foregroundColor(ThemeManager.textPrimary)
                }
                
                // Leads calculation
                VStack(alignment: .leading, spacing: 5) {
                    Text("Leads Required")
                        .font(ThemeManager.medievalHeading())
                    
                    let leadsNeeded = calculateLeadsNeeded()
                    Text("\(leadsNeeded) leads")
                        .font(.headline)
                        .foregroundColor(ThemeManager.textPrimary)
                }
                
                // Contacts calculation
                VStack(alignment: .leading, spacing: 5) {
                    Text("Contacts Required")
                        .font(ThemeManager.medievalHeading())
                    
                    let contactsNeeded = calculateContactsNeeded()
                    Text("\(contactsNeeded) contacts")
                        .font(.headline)
                        .foregroundColor(ThemeManager.textPrimary)
                }
            }
            .padding()
            .background(ThemeManager.backgroundSecondary)
            .cornerRadius(10)
            
            // Daily activity
            VStack(alignment: .leading, spacing: 10) {
                Text("Your Daily Activity Target")
                    .font(ThemeManager.medievalHeading())
                
                let dailyContacts = Int(Double(calculateContactsNeeded()) / 220.0) // Assuming 220 working days
                
                HStack {
                    Image(systemName: "calendar.badge.clock")
                        .foregroundColor(ThemeManager.accentColor)
                    
                    Text("\(dailyContacts) \(activityName()) per day")
                        .font(.headline)
                        .foregroundColor(ThemeManager.textPrimary)
                }
                
                Text("Consistently hitting this daily target will help you achieve your annual goal.")
                    .font(.caption)
                    .foregroundColor(ThemeManager.textSecondary)
            }
            .padding()
            .background(ThemeManager.backgroundSecondary)
            .cornerRadius(10)
            
            Spacer()
        }
        .padding()
    }
    
    private func calculateLeadsNeeded() -> Int {
        // Calculate leads needed based on skill level
        let leadsPerDeal: Double
        
        switch viewModel.skillLevel {
        case .beginner:
            leadsPerDeal = 15
        case .intermediate:
            leadsPerDeal = 10
        case .advanced:
            leadsPerDeal = 5
        }
        
        return Int(Double(viewModel.transactionsGoal) * leadsPerDeal)
    }
    
    private func calculateContactsNeeded() -> Int {
        let leadsNeeded = calculateLeadsNeeded()
        let contactsPerLead: Double
        
        switch (viewModel.selectedGeneratingActivity, viewModel.skillLevel) {
        case ("Cold calling", .beginner): contactsPerLead = 15
        case ("Cold calling", .intermediate): contactsPerLead = 10
        case ("Cold calling", .advanced): contactsPerLead = 5
        case ("Door knocking", .beginner): contactsPerLead = 20
        case ("Door knocking", .intermediate): contactsPerLead = 12
        case ("Door knocking", .advanced): contactsPerLead = 7
        case ("Open houses", .beginner): contactsPerLead = 15
        case ("Open houses", .intermediate): contactsPerLead = 10
        case ("Open houses", .advanced): contactsPerLead = 5
        case ("Events", .beginner): contactsPerLead = 12
        case ("Events", .intermediate): contactsPerLead = 8
        case ("Events", .advanced): contactsPerLead = 4
        case ("Paid leads", .beginner): contactsPerLead = 8
        case ("Paid leads", .intermediate): contactsPerLead = 5
        case ("Paid leads", .advanced): contactsPerLead = 3
        default: contactsPerLead = 10
        }
        
        return Int(Double(leadsNeeded) * contactsPerLead)
    }
    
    private func activityName() -> String {
        switch viewModel.selectedGeneratingActivity {
        case "Cold calling": return "calls"
        case "Door knocking": return "doors"
        case "Open houses": return "visitors"
        case "Events": return "attendees"
        case "Paid leads": return "leads"
        default: return "contacts"
        }
    }
}