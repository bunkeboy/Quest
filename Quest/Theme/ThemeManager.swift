//
//  ThemeManager.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//


// ThemeManager.swift

import SwiftUI

struct ThemeManager {
    // MARK: - Colors
    
    // Main app colors
    static let primaryColor = Color("medievalBrown")
    static let secondaryColor = Color("royalPurple")
    static let accentColor = Color("medievalGold")
    
    // Background colors
    static let backgroundPrimary = Color("parchment_background")
    static let backgroundSecondary = Color.white.opacity(0.7)
    
    // Text colors
    static let textPrimary = Color("medievalBrown").opacity(0.9)
    static let textSecondary = Color("medievalBrown").opacity(0.6)
    
    // Status colors
    static let successColor = Color("forestGreen")
    static let errorColor = Color.red
    static let warningColor = Color.orange
    
    // MARK: - Font Styles
    
    static func medievalTitle() -> Font {
        return Font.system(.title).bold()
    }
    
    static func medievalHeading() -> Font {
        return Font.system(.headline).bold()
    }
    
    static func medievalBody() -> Font {
        return Font.system(.body)
    }
    
    // MARK: - Common Styles
    
    static func parchmentBackground() -> some View {
        backgroundPrimary
            .edgesIgnoringSafeArea(.all)
    }
    
    static func scrollContainer<Content: View>(_ content: Content) -> some View {
        ScrollView {
            content
                .padding()
                .background(backgroundSecondary)
                .cornerRadius(8)
                .shadow(color: secondaryColor.opacity(0.2), radius: 4)
                .padding()
        }
        .background(backgroundPrimary)
    }
    
    static func medievalButton(_ text: String) -> some View {
        Text(text)
            .font(medievalHeading())
            .foregroundColor(.white)
            .padding()
            .background(secondaryColor)
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.2), radius: 4)
    }
}
