//
//  TournamentView.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//


// TournamentView.swift

import SwiftUI

struct TournamentView: View {
    // ViewModel to manage tournament data
    @StateObject private var viewModel = TournamentViewModel()
    
    // Mock current user ID
    let currentUserId = "1" // Change this to test different user positions
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                ThemeManager.backgroundPrimary.ignoresSafeArea()
                
                // Content
                ScrollView {
                    VStack(spacing: 24) {
                        // Weekly challenge
                        if let challenge = viewModel.weeklyChallenge {
                            challengeCard(challenge: challenge)
                        }
                        
                        // Leaderboard
                        leaderboardSection()
                    }
                    .padding()
                }
            }
            .navigationTitle("Tournament")
        }
    }
    
    private func challengeCard(challenge: Challenge) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Weekly Challenge")
                .font(ThemeManager.medievalTitle())
                .foregroundColor(ThemeManager.textPrimary)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(challenge.title)
                    .font(ThemeManager.medievalHeading())
                    .foregroundColor(ThemeManager.textPrimary)
                
                Text(challenge.description)
                    .font(ThemeManager.medievalBody())
                    .foregroundColor(ThemeManager.textSecondary)
                
                Divider()
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Reward:")
                            .font(.caption)
                            .foregroundColor(ThemeManager.textSecondary)
                        
                        HStack {
                            Image(systemName: "coins")
                                .foregroundColor(ThemeManager.accentColor)
                            Text("\(challenge.reward.gold) Gold")
                                .foregroundColor(ThemeManager.textPrimary)
                            
                            if let title = challenge.reward.title {
                                Text("+ \"\(title)\" Title")
                                    .foregroundColor(ThemeManager.textPrimary)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.hasJoinedChallenge ? viewModel.leaveChallenge() : viewModel.joinChallenge()
                    }) {
                        Text(viewModel.hasJoinedChallenge ? "Leave Challenge" : "Join Challenge")
                            .font(.callout.bold())
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(ThemeManager.secondaryColor)
                            .cornerRadius(8)
                    }
                }
            }
            .padding()
            .background(ThemeManager.backgroundSecondary)
            .cornerRadius(10)
        }
        .padding()
        .background(ThemeManager.backgroundSecondary)
        .cornerRadius(10)
        .shadow(color: ThemeManager.secondaryColor.opacity(0.1), radius: 4)
    }
    
    private func leaderboardSection() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Kingdom Rankings")
                .font(ThemeManager.medievalTitle())
                .foregroundColor(ThemeManager.textPrimary)
            
            ForEach(viewModel.leaderboardEntries, id: \.userId) { entry in
                leaderboardRow(entry: entry)
            }
        }
        .padding()
        .background(ThemeManager.backgroundSecondary)
        .cornerRadius(10)
        .shadow(color: ThemeManager.secondaryColor.opacity(0.1), radius: 4)
    }
    
    private func leaderboardRow(entry: LeaderboardEntry) -> some View {
        HStack {
            // Rank
            Text("\(entry.rank)")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(rankBackground(rank: entry.rank))
                .cornerRadius(15)
            
            // Name
            Text(entry.userName)
                .font(ThemeManager.medievalBody())
                .foregroundColor(ThemeManager.textPrimary)
                .padding(.leading, 8)
            
            Spacer()
            
            // Score
            HStack {
                Image(systemName: "trophy.fill")
                    .foregroundColor(ThemeManager.accentColor)
                Text("\(entry.score)")
                    .font(.headline)
                    .foregroundColor(ThemeManager.textPrimary)
            }
        }
        .padding()
        .background(entry.userId == currentUserId ? ThemeManager.secondaryColor.opacity(0.1) : ThemeManager.backgroundPrimary.opacity(0.5))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(entry.userId == currentUserId ? ThemeManager.secondaryColor : Color.clear, lineWidth: 1)
        )
    }
    
    private func rankBackground(rank: Int) -> Color {
        switch rank {
        case 1:
            return .gold
        case 2:
            return .silver
        case 3:
            return .bronze
        default:
            return ThemeManager.secondaryColor
        }
    }
}

// Helper color extensions for medal colors
extension Color {
    static let gold = Color(red: 1.0, green: 0.84, blue: 0.0)
    static let silver = Color(red: 0.75, green: 0.75, blue: 0.75)
    static let bronze = Color(red: 0.8, green: 0.5, blue: 0.2)
}

struct TournamentView_Previews: PreviewProvider {
    static var previews: some View {
        TournamentView()
    }
}

