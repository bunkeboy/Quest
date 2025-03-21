//
//  KingdomView.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//


// KingdomView.swift

import SwiftUI

struct KingdomView: View {
    // Mock data for testing
    let kingdom = MockDataService.getMockKingdom()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                ThemeManager.backgroundPrimary.ignoresSafeArea()
                
                // Content
                ScrollView {
                    VStack(spacing: 20) {
                        // Kingdom health indicator
                        kingdomHealthCard()
                        
                        // Kingdom sections
                        sectionCard(
                            title: "Court (Admin)", 
                            icon: "building.columns",
                            health: kingdom.court.health,
                            taskCount: kingdom.court.tasks.count,
                            completedCount: kingdom.court.tasks.filter { $0.isCompleted }.count
                        )
                        
                        sectionCard(
                            title: "Farming", 
                            icon: "leaf",
                            health: kingdom.farming.health,
                            taskCount: kingdom.farming.tasks.count,
                            completedCount: kingdom.farming.tasks.filter { $0.isCompleted }.count
                        )
                        
                        sectionCard(
                            title: "Hunting", 
                            icon: "figure.archery",
                            health: kingdom.hunting.health,
                            taskCount: kingdom.hunting.tasks.count,
                            completedCount: kingdom.hunting.tasks.filter { $0.isCompleted }.count
                        )
                        
                        sectionCard(
                            title: "Village (Pipeline)", 
                            icon: "house.and.flag",
                            health: kingdom.village.health,
                            taskCount: kingdom.village.pipeline.count,
                            completedCount: 0  // Pipeline items don't have completion status
                        )
                    }
                    .padding()
                }
            }
            .navigationTitle("Kingdom")
        }
    }
    
    private func kingdomHealthCard() -> some View {
        VStack {
            Text("Kingdom Health")
                .font(ThemeManager.medievalTitle())
                .foregroundColor(ThemeManager.textPrimary)
            
            HStack(spacing: 20) {
                healthGradeView(grade: kingdom.health)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Health Status:")
                        .font(ThemeManager.medievalHeading())
                        .foregroundColor(ThemeManager.textPrimary)
                    
                    Text(healthDescription(for: kingdom.health))
                        .font(ThemeManager.medievalBody())
                        .foregroundColor(ThemeManager.textSecondary)
                }
            }
            .padding()
            .background(ThemeManager.backgroundSecondary)
            .cornerRadius(10)
            .shadow(color: ThemeManager.secondaryColor.opacity(0.1), radius: 4)
        }
    }
    
    private func sectionCard(title: String, icon: String, health: KingdomHealth, taskCount: Int, completedCount: Int) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(ThemeManager.secondaryColor)
                
                Text(title)
                    .font(ThemeManager.medievalHeading())
                    .foregroundColor(ThemeManager.textPrimary)
                
                Spacer()
                
                healthGradeView(grade: health)
            }
            
            Divider()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Tasks: \(completedCount)/\(taskCount)")
                        .font(ThemeManager.medievalBody())
                        .foregroundColor(ThemeManager.textSecondary)
                    
                    // Progress bar
                    ProgressView(value: Double(completedCount), total: Double(taskCount))
                        .progressViewStyle(LinearProgressViewStyle(tint: ThemeManager.successColor))
                }
                
                Spacer()
                
                NavigationLink(destination: Text("Detail view for \(title)")) {
                    Text("View")
                        .font(.caption.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(ThemeManager.secondaryColor)
                        .cornerRadius(8)
                }
            }
            .padding(.top, 4)
        }
        .padding()
        .background(ThemeManager.backgroundSecondary)
        .cornerRadius(10)
        .shadow(color: ThemeManager.secondaryColor.opacity(0.1), radius: 4)
    }
    
    private func healthGradeView(grade: KingdomHealth) -> some View {
        ZStack {
            Circle()
                .fill(healthColor(for: grade))
                .frame(width: 40, height: 40)
            
            Text(healthGrade(for: grade))
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
    
    private func healthGrade(for health: KingdomHealth) -> String {
        switch health {
        case .a:
            return "A"
        case .b:
            return "B"
        case .c:
            return "C"
        }
    }
    
    private func healthColor(for health: KingdomHealth) -> Color {
        switch health {
        case .a:
            return .green
        case .b:
            return .orange
        case .c:
            return .red
        }
    }
    
    private func healthDescription(for health: KingdomHealth) -> String {
        switch health {
        case .a:
            return "Your kingdom is thriving!"
        case .b:
            return "Your kingdom is stable but could improve."
        case .c:
            return "Your kingdom needs attention!"
        }
    }
}

struct KingdomView_Previews: PreviewProvider {
    static var previews: some View {
        KingdomView()
    }
}
