//
//  MockDataService.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//


// MockDataService.swift

import Foundation

// Explicitly importing the app module to access all model types
// This will ensure the compiler knows which types to use

class MockDataService {
    // Method to get mock quests
    static func getMockQuests() -> [QuestModel] {
        return [
            QuestModel(
                id: "1",
                title: "Show a property",
                description: "Schedule and complete a property showing with a client",
                type: .pipeline,
                difficulty: .medium,
                status: .notStarted,
                rewards: QuestRewards(gold: 50, xp: 20),
                deadline: Date().addingTimeInterval(86400), // 1 day from now
                isDaily: true,
                isWeekly: false,
                isMonthly: false
            ),
            QuestModel(
                id: "2",
                title: "Make 10 prospecting calls",
                description: "Call 10 leads from your contact list",
                type: .hunting,
                difficulty: .easy,
                status: .inProgress,
                rewards: QuestRewards(gold: 30, xp: 15),
                deadline: Date().addingTimeInterval(86400), // 1 day from now
                isDaily: true,
                isWeekly: false,
                isMonthly: false
            ),
            QuestModel(
                id: "3",
                title: "Create social media post",
                description: "Post market update on your social media accounts",
                type: .farming,
                difficulty: .easy,
                status: .completed,
                rewards: QuestRewards(gold: 20, xp: 10),
                deadline: Date().addingTimeInterval(86400), // 1 day from now
                isDaily: true,
                isWeekly: false,
                isMonthly: false
            ),
            QuestModel(
                id: "4",
                title: "Complete training course",
                description: "Finish the new contracts training module",
                type: .admin,
                difficulty: .medium,
                status: .notStarted,
                rewards: QuestRewards(gold: 40, xp: 25),
                deadline: Date().addingTimeInterval(86400 * 7), // 7 days from now
                isDaily: false,
                isWeekly: true,
                isMonthly: false
            ),
            QuestModel(
                id: "5",
                title: "Submit an offer",
                description: "Prepare and submit an offer for a client",
                type: .pipeline,
                difficulty: .hard,
                status: .notStarted,
                rewards: QuestRewards(gold: 100, xp: 50),
                deadline: Date().addingTimeInterval(86400 * 3), // 3 days from now
                isDaily: false,
                isWeekly: true,
                isMonthly: false
            )
        ]
    }
    
    // Method to get mock prospects (pipeline items)
    static func getMockProspects() -> [PipelineItem] {
        return [
            PipelineItem(
                id: "1",
                title: "New Home Purchase",
                stage: "Lead",
                value: 450000,
                clientName: "John Smith",
                expectedCloseDate: Date().addingTimeInterval(86400 * 30) // 30 days from now
            ),
            PipelineItem(
                id: "2",
                title: "Condo Sale",
                stage: "Contract",
                value: 325000,
                clientName: "Emma Johnson",
                expectedCloseDate: Date().addingTimeInterval(86400 * 15) // 15 days from now
            ),
            PipelineItem(
                id: "3",
                title: "Luxury Home Listing",
                stage: "Closing",
                value: 1250000,
                clientName: "Robert Williams",
                expectedCloseDate: Date().addingTimeInterval(86400 * 5) // 5 days from now
            )
        ]
    }
    
    // Method to get mock farming tasks
    static func getMockFarmingTasks() -> [FarmingTask] {
        return [
            FarmingTask(
                id: "1",
                title: "Monthly Newsletter",
                description: "Send monthly market update newsletter",
                targetAudience: "Past Clients",
                isCompleted: false,
                frequency: .monthly,
                nextDueDate: Date().addingTimeInterval(86400 * 7) // 7 days from now
            ),
            FarmingTask(
                id: "2",
                title: "Social Media Post",
                description: "Post weekly market stats on social media",
                targetAudience: "Online Followers",
                isCompleted: true,
                frequency: .weekly,
                nextDueDate: Date().addingTimeInterval(86400 * 5) // 5 days from now
            )
        ]
    }
    
    // Method to get mock hunting tasks
    static func getMockHuntingTasks() -> [HuntingTask] {
        return [
            HuntingTask(
                id: "1",
                title: "Follow-up Call",
                description: "Call about property interest",
                prospect: "John Smith",
                isCompleted: false,
                deadline: Date().addingTimeInterval(86400 * 1) // 1 day from now
            ),
            HuntingTask(
                id: "2",
                title: "Send Listing Info",
                description: "Email new listings that match criteria",
                prospect: "Emma Johnson",
                isCompleted: true,
                deadline: Date().addingTimeInterval(86400 * 2) // 2 days from now
            )
        ]
    }
    
    // Method to get mock admin tasks
    static func getMockAdminTasks() -> [AdminTask] {
        return [
            AdminTask(
                id: "1",
                title: "Pay MLS Dues",
                description: "Quarterly MLS membership payment",
                isCompleted: false,
                deadline: Date().addingTimeInterval(86400 * 10) // 10 days from now
            ),
            AdminTask(
                id: "2",
                title: "Order Business Cards",
                description: "Reorder business cards with new branding",
                isCompleted: true,
                deadline: Date().addingTimeInterval(86400 * 15) // 15 days from now
            )
        ]
    }
    
    // Create a mock user
    static func getMockUser() -> User {
        return User(
            id: "current_user",
            displayName: "Sir Reginald",
            email: "reginald@example.com",
            role: .agent,
            teamId: "team1",
            settings: UserSettings(
                notificationsEnabled: true,
                soundEnabled: true,
                themePreference: .light
            ),
            onboardingComplete: true,
            stats: UserStats(
                totalQuestsCompleted: 42,
                currentStreak: 5,
                longestStreak: 10,
                goldEarned: 1250,
                xpPoints: 350,
                kingdomHealth: .b
            ),
            level: 3,
            rank: .knight,
            gold: 500,
            hearts: 5
        )
    }
    
    // Create a complete mock kingdom with all components
    static func getMockKingdom() -> Kingdom {
        return Kingdom(
            userId: "current_user",
            health: .b,
            court: Court(
                tasks: getMockAdminTasks(),
                health: .a
            ),
            farming: Farming(
                tasks: getMockFarmingTasks(),
                health: .b
            ),
            hunting: Hunting(
                tasks: getMockHuntingTasks(),
                health: .c
            ),
            village: Village(
                pipeline: getMockProspects(),
                health: .b
            )
        )
    }
}

