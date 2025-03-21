//
//  SettingsView.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//


// SettingsView.swift

import SwiftUI

struct SettingsView: View {
    // Mock user data
    let user = MockDataService.getMockUser()
    
    // State variables for settings
    @State private var notificationsEnabled = true
    @State private var soundEnabled = true
    @State private var themePreference: ThemePreference = .light
    
    // State for CRM connection
    @State private var isCRMConnected = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                ThemeManager.backgroundPrimary.ignoresSafeArea()
                
                // Content
                ScrollView {
                    VStack(spacing: 24) {
                        // Profile section
                        profileSection()
                        
                        // Preferences section
                        preferencesSection()
                        
                        // Connections section
                        connectionsSection()
                        
                        // About section
                        aboutSection()
                    }
                    .padding()
                }
            }
            .navigationTitle("Settings")
            .onAppear {
                // Initialize state from user settings
                notificationsEnabled = user.settings.notificationsEnabled
                soundEnabled = user.settings.soundEnabled
                themePreference = user.settings.themePreference
            }
        }
    }
    
    private func profileSection() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Profile")
                .font(ThemeManager.medievalTitle())
                .foregroundColor(ThemeManager.textPrimary)
            
            VStack {
                HStack {
                    // Profile image placeholder
                    Circle()
                        .fill(ThemeManager.secondaryColor.opacity(0.2))
                        .frame(width: 80, height: 80)
                        .overlay(
                            Text(String(user.displayName.prefix(1)))
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(ThemeManager.secondaryColor)
                        )
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.displayName)
                            .font(ThemeManager.medievalHeading())
                            .foregroundColor(ThemeManager.textPrimary)
                        
                        Text(rankName(for: user.rank))
                            .font(.caption)
                            .foregroundColor(ThemeManager.textSecondary)
                        
                        Text(user.email)
                            .font(.caption)
                            .foregroundColor(ThemeManager.textSecondary)
                    }
                    .padding(.leading, 8)
                    
                    Spacer()
                }
                .padding()
                
                Button(action: {
                    // Action to edit profile (will implement later)
                    print("Edit profile tapped")
                }) {
                    Text("Edit Profile")
                        .font(.callout.bold())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(ThemeManager.secondaryColor)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .background(ThemeManager.backgroundSecondary)
            .cornerRadius(10)
            .shadow(color: ThemeManager.secondaryColor.opacity(0.1), radius: 4)
        }
    }
    
    private func preferencesSection() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Preferences")
                .font(ThemeManager.medievalTitle())
                .foregroundColor(ThemeManager.textPrimary)
            
            VStack {
                Toggle("Notifications", isOn: $notificationsEnabled)
                    .toggleStyle(SwitchToggleStyle(tint: ThemeManager.accentColor))
                    .padding()
                
                Divider()
                    .padding(.horizontal)
                
                Toggle("Sound Effects", isOn: $soundEnabled)
                    .toggleStyle(SwitchToggleStyle(tint: ThemeManager.accentColor))
                    .padding()
                
                Divider()
                    .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text("Theme")
                        .foregroundColor(ThemeManager.textPrimary)
                        .padding(.horizontal)
                        .padding(.top, 8)
                    
                    Picker("Theme", selection: $themePreference) {
                        Text("Light").tag(ThemePreference.light)
                        Text("Dark").tag(ThemePreference.dark)
                        Text("System").tag(ThemePreference.system)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
            }
            .background(ThemeManager.backgroundSecondary)
            .cornerRadius(10)
            .shadow(color: ThemeManager.secondaryColor.opacity(0.1), radius: 4)
        }
    }
    
    private func connectionsSection() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Connections")
                .font(ThemeManager.medievalTitle())
                .foregroundColor(ThemeManager.textPrimary)
            
            VStack {
                HStack {
                    Image(systemName: "link")
                        .foregroundColor(ThemeManager.secondaryColor)
                    
                    Text("Follow Up Boss")
                        .foregroundColor(ThemeManager.textPrimary)
                    
                    Spacer()
                    
                    if isCRMConnected {
                        HStack {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 10, height: 10)
                            Text("Connected")
                                .font(.caption)
                                .foregroundColor(Color.green)
                        }
                        
                        Button(action: {
                            // Disconnect action (to be implemented)
                            isCRMConnected = false
                        }) {
                            Text("Disconnect")
                                .font(.caption)
                                .foregroundColor(.red)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.red, lineWidth: 1)
                                )
                        }
                        .padding(.leading, 8)
                    } else {
                        Button(action: {
                            // Connect action (to be implemented)
                            isCRMConnected = true
                        }) {
                            Text("Connect")
                                .font(.caption.bold())
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(ThemeManager.secondaryColor)
                                .cornerRadius(4)
                        }
                    }
                }
                .padding()
            }
            .background(ThemeManager.backgroundSecondary)
            .cornerRadius(10)
            .shadow(color: ThemeManager.secondaryColor.opacity(0.1), radius: 4)
        }
    }
    
    private func aboutSection() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("About")
                .font(ThemeManager.medievalTitle())
                .foregroundColor(ThemeManager.textPrimary)
            
            VStack {
                Button(action: {
                    // Help action (to be implemented)
                    print("Help tapped")
                }) {
                    HStack {
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(ThemeManager.secondaryColor)
                        
                        Text("Help")
                            .foregroundColor(ThemeManager.textPrimary)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(ThemeManager.textSecondary)
                    }
                    .padding()
                }
                
                Divider()
                    .padding(.horizontal)
                
                Button(action: {
                    // Terms action (to be implemented)
                    print("Terms tapped")
                }) {
                    HStack {
                        Image(systemName: "doc.text")
                            .foregroundColor(ThemeManager.secondaryColor)
                        
                        Text("Terms & Conditions")
                            .foregroundColor(ThemeManager.textPrimary)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(ThemeManager.textSecondary)
                    }
                    .padding()
                }
                
                Divider()
                    .padding(.horizontal)
                
                Button(action: {
                    // Privacy action (to be implemented)
                    print("Privacy tapped")
                }) {
                    HStack {
                        Image(systemName: "lock.shield")
                            .foregroundColor(ThemeManager.secondaryColor)
                        
                        Text("Privacy Policy")
                            .foregroundColor(ThemeManager.textPrimary)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(ThemeManager.textSecondary)
                    }
                    .padding()
                }
                
                Divider()
                    .padding(.horizontal)
                
                HStack {
                    Text("Version")
                        .foregroundColor(ThemeManager.textPrimary)
                    
                    Spacer()
                    
                    Text("1.0.0")
                        .foregroundColor(ThemeManager.textSecondary)
                }
                .padding()
            }
            .background(ThemeManager.backgroundSecondary)
            .cornerRadius(10)
            .shadow(color: ThemeManager.secondaryColor.opacity(0.1), radius: 4)
        }
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
