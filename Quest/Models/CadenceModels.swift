//
//  BusinessSource.swift
//  Quest
//
//  Created by Ryan Bunke on 3/21/25.
//


//
//  CadenceModels.swift
//  Quest
//

import Foundation
import SwiftUI


enum GoalType: String, CaseIterable, Identifiable {
    case commission = "Commission Income"
    case deals = "Deals Closed"
    case volume = "Deal Volume"
    
    var id: String { self.rawValue }
}


// Business source types
enum BusinessSource: String, CaseIterable, Identifiable {
    case sourcedLeads = "Sourced Leads"
    case newLeads = "New Leads"
    case sphere = "Sphere"
    case pastClients = "Past Clients"
    case referrals = "Referrals"
    case other = "Other"
    
    var id: String { self.rawValue }
}


// Activity types
enum NurturingActivity: String, CaseIterable, Identifiable {
    case phoneCalls = "Phone Calls"
    case doorknocking = "Doorknocking"
    case newsletters = "Newsletters"
    case events = "Events"
    case socialMedia = "Social Media"
    case directMail = "Direct Mail"
    case gifts = "Gifts"
    case other = "Other"
    
    var id: String { self.rawValue }
}

// Cadence types
enum CadenceType: String, CaseIterable, Identifiable {
    case daily = "Daily"
    case weekly = "Weekly"
    case monthly = "Monthly"
    case quarterly = "Quarterly"
    case annual = "Annual"
    
    var id: String { self.rawValue }
    
    // Window duration for each cadence type
    var completionWindow: TimeInterval {
        switch self {
        case .daily:
            return 24 * 60 * 60 // 24 hours
        case .weekly:
            return 2 * 24 * 60 * 60 // 48 hours
        case .monthly:
            return 7 * 24 * 60 * 60 // 7 days
        case .quarterly:
            return 28 * 24 * 60 * 60 // 4 weeks
        case .annual:
            return 0 // Must be scheduled manually
        }
    }
}

// Activity tile model
struct ActivityTile: Identifiable {
    let id = UUID()
    let source: BusinessSource
    let activity: NurturingActivity
    var totalCount: Int
    var unallocatedCount: Int
    
    // Dictionary to track allocations by cadence type
    var allocations: [CadenceType: Int] = [:]
}

// Quest cadence model
struct QuestCadence {
    var activityTiles: [ActivityTile] = []
    
    // Calculate daily gold based on cadence allocations
    func calculateDailyGold() -> Int {
        var goldPerDay = 0
        
        // Count tiles per cadence type
        var tileCountByType: [CadenceType: Int] = [:]
        var filledCadenceTypes = 0
        
        for tile in activityTiles {
            for (cadenceType, count) in tile.allocations {
                if count > 0 {
                    tileCountByType[cadenceType, default: 0] += 1
                }
            }
        }
        
        // Calculate based on rules
        for cadenceType in CadenceType.allCases {
            let tilesInCadence = tileCountByType[cadenceType, default: 0]
            
            if tilesInCadence > 0 {
                filledCadenceTypes += 1
                
                if tilesInCadence >= 5 {
                    // 10 gold per day for 5+ tiles
                    goldPerDay += 10
                } else {
                    // 5 gold per day per tile
                    goldPerDay += 5 * tilesInCadence
                }
            }
        }
        
        // Apply 2x multiplier if all cadence types have at least one tile
        if filledCadenceTypes == CadenceType.allCases.count {
            goldPerDay *= 2
        }
        
        return goldPerDay
    }
}
