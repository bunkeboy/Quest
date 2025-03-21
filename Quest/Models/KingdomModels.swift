//
//  Kingdom.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//
import Foundation

struct Kingdom {
    let userId: String
    var health: KingdomHealth
    var court: Court
    var farming: Farming
    var hunting: Hunting
    var village: Village
}

struct Court {
    var tasks: [AdminTask]
    var health: KingdomHealth
}

struct AdminTask {
    let id: String
    let title: String
    let description: String
    var isCompleted: Bool
    let deadline: Date
}

struct Farming {
    var tasks: [FarmingTask]
    var health: KingdomHealth
}

struct FarmingTask {
    let id: String
    let title: String
    let description: String
    let targetAudience: String
    var isCompleted: Bool
    let frequency: TaskFrequency
    let nextDueDate: Date
}

struct Hunting {
    var tasks: [HuntingTask]
    var health: KingdomHealth
}

struct HuntingTask {
    let id: String
    let title: String
    let description: String
    let prospect: String
    var isCompleted: Bool
    let deadline: Date
}

struct Village {
    var pipeline: [PipelineItem]
    var health: KingdomHealth
}

struct PipelineItem {
    let id: String
    let title: String
    let stage: String // From CRM
    let value: Double
    let clientName: String
    let expectedCloseDate: Date
}

enum TaskFrequency {
    case daily
    case weekly
    case monthly
    case quarterly
    case custom(days: Int)
}