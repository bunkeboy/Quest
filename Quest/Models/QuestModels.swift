//
//  Quest.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//
import Foundation

// Renamed from Quest to QuestModel to avoid ambiguity with app name
struct QuestModel {
    let id: String
    let title: String
    let description: String
    let type: QuestType
    let difficulty: QuestDifficulty
    var status: QuestStatus
    let rewards: QuestRewards
    let deadline: Date
    let isDaily: Bool
    let isWeekly: Bool
    let isMonthly: Bool
}

enum QuestType {
    case admin // Court
    case farming // Repetitive prospecting
    case hunting // Need-based prospecting
    case pipeline // Village
    case challenge // Special timed challenge
}

enum QuestDifficulty {
    case easy
    case medium
    case hard
}

enum QuestStatus {
    case notStarted
    case inProgress
    case completed
}

struct QuestRewards {
    let gold: Int
    let xp: Int
}
