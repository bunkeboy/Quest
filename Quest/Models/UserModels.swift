//
//  User.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//
import Foundation

struct User {
    let id: String
    let displayName: String
    let email: String
    let role: UserRole
    let teamId: String?
    var settings: UserSettings
    var onboardingComplete: Bool
    var stats: UserStats
    var level: Int
    var rank: Rank
    var gold: Int
    var hearts: Int
}

enum UserRole {
    case agent
    case teamLeader
    case admin
}

struct UserSettings {
    var notificationsEnabled: Bool
    var soundEnabled: Bool
    var themePreference: ThemePreference
}

enum ThemePreference {
    case light
    case dark
    case system
}

struct UserStats {
    var totalQuestsCompleted: Int
    var currentStreak: Int
    var longestStreak: Int
    var goldEarned: Int
    var xpPoints: Int
    var kingdomHealth: KingdomHealth
}

enum KingdomHealth {
    case a // Good
    case b // Average
    case c // Needs improvement
}

enum Rank {
    case noviceSquire
    case knight
    case lord
    case baron
    case duke
    case royalty
}
