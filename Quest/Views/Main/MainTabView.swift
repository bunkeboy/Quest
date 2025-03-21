//
//  MainTabView.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//


// MainTabView.swift

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            QuestsView()
                .tabItem {
                    Label("Quests", systemImage: "scroll")
                }
            
            KingdomView()
                .tabItem {
                    Label("Kingdom", systemImage: "house")
                }
            
            PalaceView()
                .tabItem {
                    Label("Palace", systemImage: "crown")
                }
            
            TournamentView()
                .tabItem {
                    Label("Tournament", systemImage: "trophy")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .accentColor(ThemeManager.accentColor)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
