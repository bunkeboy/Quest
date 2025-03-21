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
                    Label {
                        Text("Quests")
                    } icon: {
                        Image("quest-icon")
                    }
                }
            
            KingdomView()
                .tabItem {
                    Label {
                        Text("Kingdom")
                    } icon: {
                        Image("kingdom-icon")
                    }
                }
            
            PalaceView()
                .tabItem {
                    Label {
                        Text("Palace")
                    } icon: {
                        Image("palace-icon")
                    }
                }
            
            TournamentView()
                .tabItem {
                    Label {
                        Text("Tournament")
                    } icon: {
                        Image("tournament-icon")
                    }
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
