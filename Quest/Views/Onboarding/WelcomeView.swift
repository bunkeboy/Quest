//
//  WelcomeView.swift
//  Quest
//
//  Created by Ryan Bunke on 3/21/25.
//


//
//  WelcomeView.swift
//  Quest
//

import SwiftUI

struct WelcomeView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var animate = false
    
    var body: some View {
        VStack(spacing: 30) {
            // Title
            Text("Welcome to Quest")
                .font(ThemeManager.medievalTitle())
                .foregroundColor(ThemeManager.textPrimary)
                .opacity(animate ? 1 : 0)
                .animation(.easeIn(duration: 1.0), value: animate)
            
            // Animated logo/crown
            Image(systemName: "crown.fill")
                .font(.system(size: animate ? 80 : 30))
                .foregroundColor(ThemeManager.accentColor)
                .scaleEffect(animate ? 1.0 : 0.5)
                .animation(.spring(response: 0.8, dampingFraction: 0.6), value: animate)
            
            // Welcome message
            VStack(spacing: 15) {
                Text("Turn your real estate journey into an epic adventure")
                    .font(ThemeManager.medievalHeading())
                    .foregroundColor(ThemeManager.textPrimary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .opacity(animate ? 1 : 0)
                    .animation(.easeIn(duration: 1.2).delay(0.3), value: animate)
                
                Text("Complete quests, build your kingdom, and earn rewards as you grow your business")
                    .font(ThemeManager.medievalBody())
                    .foregroundColor(ThemeManager.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .opacity(animate ? 1 : 0)
                    .animation(.easeIn(duration: 1.2).delay(0.6), value: animate)
            }
            
            Spacer()
            
            // Start button
            Button(action: {
                viewModel.nextStep()
            }) {
                Text("Begin Your Quest")
                    .font(ThemeManager.medievalHeading())
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(ThemeManager.secondaryColor)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .opacity(animate ? 1 : 0)
                    .animation(.easeIn(duration: 1.0).delay(1.0), value: animate)
            }
        }
        .padding(.vertical, 50)
        .onAppear {
            // Start animation when view appears
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                animate = true
            }
        }
    }
}