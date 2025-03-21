//
//  Tournament.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//
import Foundation

struct Tournament {
    let id: String
    let name: String
    let startDate: Date
    let endDate: Date
    let challenge: Challenge
    var participants: [String] // User IDs
    var leaderboard: [LeaderboardEntry]
}

struct Challenge {
    let id: String
    let title: String
    let description: String
    let targetMetric: TargetMetric
    let reward: ChallengeReward
}

enum TargetMetric {
    case questsCompleted
    case goldEarned
    case callsMade
    case propertiesShown
    case listingsTaken
    case dealsCompleted
}

struct ChallengeReward {
    let gold: Int
    let item: InventoryItem?
    let title: String?
}

struct LeaderboardEntry {
    let userId: String
    let userName: String
    let score: Int
    let rank: Int
}
