//
//  QuestCadenceView.swift
//  Quest
//
//  Created by Ryan Bunke on 3/21/25.
//


//
//  QuestCadenceView.swift
//  Quest
//

import SwiftUI

struct QuestCadenceView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var draggedTile: ActivityTile?
    @State private var showAllocationSheet = false
    @State private var selectedCadence: CadenceType?
    @State private var allocationAmount: Int = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Build Your Quest Cadence")
                .font(ThemeManager.medievalTitle())
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Allocate your activities into different cadences")
                .font(ThemeManager.medievalBody())
                .multilineTextAlignment(.center)
                .foregroundColor(ThemeManager.textSecondary)
                .padding(.horizontal)
            
            // Display current gold bonus
            VStack {
                HStack {
                    Image(systemName: "coins")
                        .foregroundColor(ThemeManager.accentColor)
                    
                    Text("Daily Gold Bonus: \(viewModel.questCadence.calculateDailyGold()) gold")
                        .font(.headline)
                        .foregroundColor(ThemeManager.textPrimary)
                }
                .padding()
                .background(ThemeManager.backgroundSecondary)
                .cornerRadius(10)
            }
            
            // Cadence boxes
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(CadenceType.allCases) { cadenceType in
                        cadenceBox(for: cadenceType)
                    }
                }
            }
            
            // Available activity tiles carousel
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.questCadence.activityTiles) { tile in
                        if tile.unallocatedCount > 0 {
                            activityTileView(tile)
                                .onTapGesture {
                                    viewModel.selectedTile = tile
                                }
                        }
                    }
                    
                    // Add new activity button
                    Button(action: {
                        viewModel.resetActivitySelections()
                        viewModel.currentStep = 10 // Add a new step for activity creation
                    }) {
                        VStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 24))
                                .foregroundColor(ThemeManager.accentColor)
                            
                            Text("New Activity")
                                .font(.caption)
                        }
                        .frame(width: 100, height: 70)
                        .background(ThemeManager.backgroundSecondary)
                        .cornerRadius(8)
                    }
                }
                .padding()
            }
            .background(ThemeManager.backgroundSecondary.opacity(0.5))
            .cornerRadius(10)
        }
        .padding()
        .sheet(isPresented: $showAllocationSheet) {
            allocationSheet()
        }
    }
    
    private func cadenceBox(for cadenceType: CadenceType) -> some View {
        VStack(alignment: .leading) {
            Text(cadenceType.rawValue)
                .font(ThemeManager.medievalHeading())
                .padding(.bottom, 5)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(isCadenceEmpty(cadenceType) 
                          ? Color.gray.opacity(0.2) 
                          : ThemeManager.backgroundSecondary)
                    .frame(height: 100)
                
                // Tiles in this cadence
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.questCadence.activityTiles) { tile in
                            if let allocation = tile.allocations[cadenceType], allocation > 0 {
                                allocatedTileView(tile, cadenceType: cadenceType, count: allocation)
                            }
                        }
                    }
                    .padding(8)
                }
                
                // Drop target overlay
                if viewModel.selectedTile != nil {
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [5]))
                        .foregroundColor(ThemeManager.accentColor)
                        .onTapGesture {
                            guard let tile = viewModel.selectedTile else { return }
                            selectedCadence = cadenceType
                            allocationAmount = viewModel.suggestedAllocation(tile: tile, cadence: cadenceType)
                            showAllocationSheet = true
                        }
                }
            }
        }
    }
    
    private func activityTileView(_ tile: ActivityTile) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(tile.activity.rawValue)")
                .font(.caption.bold())
                .foregroundColor(ThemeManager.textPrimary)
            
            Text("\(tile.source.rawValue)")
                .font(.caption)
                .foregroundColor(ThemeManager.textSecondary)
            
            Text("Left: \(tile.unallocatedCount)")
                .font(.caption)
                .foregroundColor(ThemeManager.accentColor)
        }
        .padding(8)
        .frame(width: 100, height: 70)
        .background(viewModel.selectedTile?.id == tile.id ? 
                    ThemeManager.accentColor.opacity(0.2) : ThemeManager.backgroundSecondary)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(viewModel.selectedTile?.id == tile.id ? 
                        ThemeManager.accentColor : Color.clear, lineWidth: 2)
        )
    }
    
    private func allocatedTileView(_ tile: ActivityTile, cadenceType: CadenceType, count: Int) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(tile.activity.rawValue)")
                .font(.caption.bold())
                .foregroundColor(ThemeManager.textPrimary)
            
            Text("\(tile.source.rawValue)")
                .font(.caption)
                .foregroundColor(ThemeManager.textSecondary)
            
            Text("\(count) allocated")
                .font(.caption)
                .foregroundColor(ThemeManager.accentColor)
        }
        .padding(8)
        .frame(width: 100, height: 70)
        .background(ThemeManager.backgroundSecondary)
        .cornerRadius(8)
    }
    
    private func allocationSheet() -> some View {
        VStack(spacing: 20) {
            Text("Allocate Activities")
                .font(.headline)
            
            if let tile = viewModel.selectedTile, let cadence = selectedCadence {
                Text("How many \(tile.activity.rawValue) for \(tile.source.rawValue) would you like to allocate to \(cadence.rawValue)?")
                    .multilineTextAlignment(.center)
                    .padding()
                
                Stepper("\(allocationAmount) Activities", value: $allocationAmount, in: 1...tile.unallocatedCount)
                    .padding()
                
                Button("Allocate") {
                    if let tile = viewModel.selectedTile, let cadence = selectedCadence {
                        _ = viewModel.allocateActivities(tile: tile, cadence: cadence, count: allocationAmount)
                        showAllocationSheet = false
                        viewModel.selectedTile = nil
                    }
                }
                .padding()
                .background(ThemeManager.secondaryColor)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("Cancel") {
                    showAllocationSheet = false
                }
                .padding()
                .foregroundColor(ThemeManager.secondaryColor)
            }
        }
        .padding()
    }
    
    private func isCadenceEmpty(_ cadenceType: CadenceType) -> Bool {
        for tile in viewModel.questCadence.activityTiles {
            if let allocation = tile.allocations[cadenceType], allocation > 0 {
                return false
            }
        }
        return true
    }
}
