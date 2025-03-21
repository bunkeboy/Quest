//
//  PalaceView.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//


// PalaceView.swift

import SwiftUI

struct PalaceView: View {
    // Mock data
    let user = MockDataService.getMockUser()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                ThemeManager.backgroundPrimary.ignoresSafeArea()
                
                // Content
                ScrollView {
                    VStack(spacing: 20) {
                        // Treasury stats
                        treasuryCard()
                        
                        // Palace features
                        featuresGrid()
                    }
                    .padding()
                }
            }
            .navigationTitle("Palace")
        }
    }
    
    private func treasuryCard() -> some View {
        VStack {
            Text("Royal Treasury")
                .font(ThemeManager.medievalTitle())
                .foregroundColor(ThemeManager.textPrimary)
            
            // Gold and stats
            HStack(spacing: 20) {
                // Gold amount
                VStack {
                    Image(systemName: "coins")
                        .font(.system(size: 30))
                        .foregroundColor(ThemeManager.accentColor)
                    
                    Text("\(user.gold)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(ThemeManager.textPrimary)
                    
                    Text("Gold")
                        .font(.caption)
                        .foregroundColor(ThemeManager.textSecondary)
                }
                .frame(width: 80, height: 100)
                .background(ThemeManager.backgroundSecondary)
                .cornerRadius(10)
                
                // Level
                VStack {
                    Image(systemName: "star.fill")
                        .font(.system(size: 30))
                        .foregroundColor(ThemeManager.accentColor)
                    
                    Text("\(user.level)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(ThemeManager.textPrimary)
                    
                    Text("Level")
                        .font(.caption)
                        .foregroundColor(ThemeManager.textSecondary)
                }
                .frame(width: 80, height: 100)
                .background(ThemeManager.backgroundSecondary)
                .cornerRadius(10)
                
                // Streak
                VStack {
                    Image(systemName: "flame.fill")
                        .font(.system(size: 30))
                        .foregroundColor(ThemeManager.accentColor)
                    
                    Text("\(user.stats.currentStreak)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(ThemeManager.textPrimary)
                    
                    Text("Streak")
                        .font(.caption)
                        .foregroundColor(ThemeManager.textSecondary)
                }
                .frame(width: 80, height: 100)
                .background(ThemeManager.backgroundSecondary)
                .cornerRadius(10)
            }
            .padding()
            
            // XP Progress
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("Experience")
                        .font(ThemeManager.medievalHeading())
                        .foregroundColor(ThemeManager.textPrimary)
                    
                    Spacer()
                    
                    Text("\(user.stats.xpPoints) / 500 XP")
                        .font(.caption)
                        .foregroundColor(ThemeManager.textSecondary)
                }
                
                ProgressView(value: Float(user.stats.xpPoints), total: 500)
                    .progressViewStyle(LinearProgressViewStyle(tint: ThemeManager.accentColor))
                
                Text("Current Rank: \(rankName(for: user.rank))")
                    .font(.caption)
                    .foregroundColor(ThemeManager.textSecondary)
                    .padding(.top, 2)
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
    
    private func featuresGrid() -> some View {
        VStack(alignment: .leading) {
            Text("Palace Features")
                .font(ThemeManager.medievalTitle())
                .foregroundColor(ThemeManager.textPrimary)
                .padding(.bottom, 10)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                // Items
                featureCard(title: "Items", icon: "backpack.fill", isLocked: false)
                
                // Forge (locked feature)
                featureCard(title: "Forge", icon: "hammer.fill", isLocked: true)
                
                // Stable (locked feature)
                featureCard(title: "Stable", icon: "hare.fill", isLocked: true)
                
                // Throne Room
                featureCard(title: "Throne Room", icon: "crown.fill", isLocked: false)
            }
        }
        .padding()
        .background(ThemeManager.backgroundSecondary)
        .cornerRadius(10)
        .shadow(color: ThemeManager.secondaryColor.opacity(0.1), radius: 4)
    }
    
    private func featureCard(title: String, icon: String, isLocked: Bool) -> some View {
        VStack {
            if isLocked {
                ZStack {
                    Image(systemName: icon)
                        .font(.system(size: 40))
                        .foregroundColor(ThemeManager.textSecondary.opacity(0.5))
                    
                    Image(systemName: "lock.fill")
                        .font(.system(size: 20))
                        .foregroundColor(ThemeManager.secondaryColor)
                        .offset(x: 15, y: 15)
                }
            } else {
                Image(systemName: icon)
                    .font(.system(size: 40))
                    .foregroundColor(ThemeManager.accentColor)
            }
            
            Text(title)
                .font(ThemeManager.medievalHeading())
                .foregroundColor(isLocked ? ThemeManager.textSecondary.opacity(0.5) : ThemeManager.textPrimary)
            
            if isLocked {
                Text("Locked")
                    .font(.caption)
                    .foregroundColor(ThemeManager.textSecondary.opacity(0.5))
            }
        }
        .frame(height: 120)
        .frame(maxWidth: .infinity)
        .background(ThemeManager.backgroundPrimary.opacity(0.5))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isLocked ? ThemeManager.textSecondary.opacity(0.3) : ThemeManager.accentColor.opacity(0.3), lineWidth: 1)
        )
    }
    
    private func rankName(for rank: Rank) -> String {
        switch rank {
        case .noviceSquire:
            return "Novice Squire"
        case .knight:
            return "Knight"
        case .lord:
            return "Lord"
        case .baron:
            return "Baron"
        case .duke:
            return "Duke"
        case .royalty:
            return "Royalty"
        }
    }
}

struct PalaceView_Previews: PreviewProvider {
    static var previews: some View {
        PalaceView()
    }
}
