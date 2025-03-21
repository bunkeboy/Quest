//
//  Team.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//
import Foundation

struct Team {
    let id: String
    let name: String
    let leaderId: String
    var memberIds: [String]
    let createdAt: Date
}

struct TeamMember {
    let userId: String
    let name: String
    let rank: Rank
    let joinDate: Date
    var performance: TeamMemberPerformance
}

struct TeamMemberPerformance {
    var questsCompletedThisWeek: Int
    var goldEarnedThisWeek: Int
    var currentStreak: Int
}