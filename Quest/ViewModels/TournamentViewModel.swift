//
//  TournamentViewModel.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//


// TournamentViewModel.swift

import Foundation
import SwiftUI

class TournamentViewModel: ObservableObject {
    @Published var leaderboardEntries: [LeaderboardEntry] = []
    @Published var weeklyChallenge: Challenge?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var hasJoinedChallenge = false
    
    let currentUserId = "1" // Would come from authentication in a real app
    
    init() {
        loadTournamentData()
    }
    
    func loadTournamentData() {
        isLoading = true
        
        // In a real app, this would load from Firebase or another service
        // For now, we're using mock data
        leaderboardEntries = [
            LeaderboardEntry(userId: "1", userName: "Sir Reginald", score: 1250, rank: 1),
            LeaderboardEntry(userId: "2", userName: "Lady Eleanor", score: 1180, rank: 2),
            LeaderboardEntry(userId: "3", userName: "Knight Thomas", score: 950, rank: 3),
            LeaderboardEntry(userId: "4", userName: "Squire William", score: 820, rank: 4),
            LeaderboardEntry(userId: "5", userName: "Baron James", score: 780, rank: 5)
        ]
        
        // Create a weekly challenge using the Challenge type from TournamentModels
        weeklyChallenge = Challenge(
            id: "challenge1", 
            title: "Call Champion", 
            description: "Make the most prospecting calls this week", 
            targetMetric: TargetMetric.callsMade,
            // Pass nil for the item since we don't have an InventoryItem for this challenge
            reward: ChallengeReward(gold: 200, item: nil, title: "Call Master")
        )
        
        isLoading = false
    }
    
    func joinChallenge() {
        guard let challenge = weeklyChallenge else { return }
        
        // In a real app, this would update the database
        print("Joining challenge: \(challenge.id)")
        hasJoinedChallenge = true
        
        // In a real app, you would save this to your database
    }
    
    func leaveChallenge() {
        guard let challenge = weeklyChallenge else { return }
        
        // In a real app, this would update the database
        print("Leaving challenge: \(challenge.id)")
        hasJoinedChallenge = false
        
        // In a real app, you would save this to your database
    }
}
