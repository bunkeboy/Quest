//
//  Achievement.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//
import Foundation

struct Achievement {
    let id: String
    let userId: String
    let type: AchievementType
    let earnedDate: Date
    let metadata: [String: Any]
}

enum AchievementType {
    case questMilestone(count: Int)
    case streakMilestone(days: Int)
    case goldMilestone(amount: Int)
    case levelUp(level: Int)
    case kingdomHealth(health: KingdomHealth)
    case specialEvent(name: String)
}