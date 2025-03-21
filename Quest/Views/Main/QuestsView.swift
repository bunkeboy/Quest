//
//  QuestsView.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//


// QuestsView.swift

import SwiftUI

struct QuestsView: View {
    // Mock data for initial testing
    let quests = MockDataService.getMockQuests()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                ThemeManager.backgroundPrimary.ignoresSafeArea()
                
                // Content
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Daily Quests")
                            .font(ThemeManager.medievalTitle())
                            .foregroundColor(ThemeManager.textPrimary)
                            .padding(.horizontal)
                        
                        // Display quests
                        ForEach(quests.filter { $0.isDaily }, id: \.id) { quest in
                            questCard(quest: quest)
                        }
                        
                        Text("Weekly Quests")
                            .font(ThemeManager.medievalTitle())
                            .foregroundColor(ThemeManager.textPrimary)
                            .padding(.horizontal)
                            .padding(.top)
                        
                        // Display weekly quests
                        ForEach(quests.filter { $0.isWeekly }, id: \.id) { quest in
                            questCard(quest: quest)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Quests")
        }
    }
    
    @ViewBuilder
    func questCard(quest: QuestModel) -> some View {
        VStack(alignment: .leading) {
            HStack {
                // Title and difficulty
                VStack(alignment: .leading) {
                    Text(quest.title)
                        .font(ThemeManager.medievalHeading())
                        .foregroundColor(ThemeManager.textPrimary)
                    
                    Text(difficultyText(for: quest.difficulty))
                        .font(.caption)
                        .foregroundColor(difficultyColor(for: quest.difficulty))
                }
                
                Spacer()
                
                // Status indicator
                statusView(for: quest.status)
            }
            
            // Description
            Text(quest.description)
                .font(ThemeManager.medievalBody())
                .foregroundColor(ThemeManager.textSecondary)
                .padding(.top, 4)
            
            // Rewards
            HStack {
                Image(systemName: "coins")
                    .foregroundColor(ThemeManager.accentColor)
                Text("\(quest.rewards.gold) Gold")
                    .foregroundColor(ThemeManager.textSecondary)
                
                Spacer()
                
                // Complete button (if not completed)
                if quest.status != .completed {
                    Button(action: {
                        // Action to complete quest (will implement later)
                        print("Completing quest: \(quest.id)")
                    }) {
                        Text("Complete Quest")
                            .font(.caption.bold())
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(ThemeManager.secondaryColor)
                            .cornerRadius(8)
                    }
                }
            }
        }
        .padding()
        .background(ThemeManager.backgroundSecondary)
        .cornerRadius(10)
        .shadow(color: ThemeManager.secondaryColor.opacity(0.1), radius: 4)
        .padding(.horizontal)
    }
    
    private func difficultyText(for difficulty: QuestDifficulty) -> String {
        switch difficulty {
        case .easy:
            return "Easy"
        case .medium:
            return "Medium"
        case .hard:
            return "Hard"
        }
    }
    
    private func difficultyColor(for difficulty: QuestDifficulty) -> Color {
        switch difficulty {
        case .easy:
            return .green
        case .medium:
            return .orange
        case .hard:
            return .red
        }
    }
    
    private func statusView(for status: QuestStatus) -> some View {
        switch status {
        case .notStarted:
            return HStack {
                Circle()
                    .fill(.gray)
                    .frame(width: 10, height: 10)
                Text("Not Started")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
        case .inProgress:
            return HStack {
                Circle()
                    .fill(.blue)
                    .frame(width: 10, height: 10)
                Text("In Progress")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
            
        case .completed:
            return HStack {
                Circle()
                    .fill(.green)
                    .frame(width: 10, height: 10)
                Text("Completed")
                    .font(.caption)
                    .foregroundColor(.green)
            }
        }
    }
}

struct QuestsView_Previews: PreviewProvider {
    static var previews: some View {
        QuestsView()
    }
}
