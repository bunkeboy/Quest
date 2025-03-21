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

//
//  QuestCadenceView.swift
//  Quest
//

import SwiftUI

struct QuestCadenceView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showAllocationSheet = false
    @State private var selectedCadence: CadenceType?
    @State private var allocationAmount: Int = 0
    @State private var draggedTileID: UUID?
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Build Your Quest Cadence")
                .font(ThemeManager.medievalTitle())
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Drag activities into different cadence boxes")
                .font(ThemeManager.medievalBody())
                .multilineTextAlignment(.center)
                .foregroundColor(ThemeManager.textSecondary)
                .padding(.horizontal)
            
            // Gold bonus card
            HStack {
                Image(systemName: "coins")
                    .foregroundColor(ThemeManager.accentColor)
                
                Text("Daily Gold Bonus: \(viewModel.questCadence.calculateDailyGold())")
                    .font(.headline)
                    .foregroundColor(ThemeManager.textPrimary)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(ThemeManager.backgroundSecondary)
            .cornerRadius(10)
            .padding(.horizontal)
            
            // Cadence boxes
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(CadenceType.allCases) { cadenceType in
                        cadenceBox(for: cadenceType)
                    }
                }
                .padding(.horizontal)
            }
            
            // Available activity tiles carousel
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.questCadence.activityTiles) { tile in
                        if tile.unallocatedCount > 0 {
                            activityTileView(tile)
                                .onDrag {
                                    // Set the dragged tile ID
                                    self.draggedTileID = tile.id
                                    // Return NSItemProvider with the tile ID as string
                                    return NSItemProvider(object: tile.id.uuidString as NSString)
                                }
                        }
                    }
                    
                    // Add new activity button
                    Button(action: {
                        viewModel.resetActivitySelections()
                        viewModel.currentStep = 10 // Set to the activity creation step
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
            .padding(.horizontal)
        }
        .padding(.vertical)
        .sheet(isPresented: $showAllocationSheet) {
            allocationSheet()
        }
    }
    
    private func cadenceBox(for cadenceType: CadenceType) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(cadenceType.rawValue)
                    .font(ThemeManager.medievalHeading())
                
                Spacer()
                
                // Show bonus amount for this cadence
                if !isCadenceEmpty(cadenceType) {
                    HStack {
                        Image(systemName: "coins")
                            .foregroundColor(ThemeManager.accentColor)
                            .font(.caption)
                        
                        let tileCount = countTilesInCadence(cadenceType)
                        let goldAmount = tileCount >= 5 ? 10 : 5 * tileCount
                        
                        Text("\(goldAmount)/day")
                            .font(.caption)
                            .foregroundColor(ThemeManager.accentColor)
                    }
                }
            }
            
            // Drop area for activities
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(isCadenceEmpty(cadenceType)
                          ? Color.gray.opacity(0.2)
                          : ThemeManager.backgroundSecondary)
                    .frame(height: 100)
                
                if isCadenceEmpty(cadenceType) {
                    // Empty state
                    VStack {
                        Image(systemName: "arrow.down.doc.fill")
                            .font(.system(size: 24))
                            .foregroundColor(Color.gray.opacity(0.5))
                        
                        Text("Drop activities here")
                            .font(.caption)
                            .foregroundColor(Color.gray.opacity(0.7))
                    }
                } else {
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
                }
            }
            .onDrop(of: ["public.utf8-plain-text"], isTargeted: nil) { providers, _ in
                // Handle the drop
                guard let draggedTileID = self.draggedTileID else { return false }
                
                // Find the tile
                guard let tileIndex = viewModel.questCadence.activityTiles.firstIndex(where: { $0.id == draggedTileID }) else {
                    return false
                }
                
                let tile = viewModel.questCadence.activityTiles[tileIndex]
                
                // Show allocation sheet
                self.selectedCadence = cadenceType
                self.allocationAmount = viewModel.suggestedAllocation(tile: tile, cadence: cadenceType)
                self.showAllocationSheet = true
                
                return true
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
        .background(ThemeManager.backgroundSecondary)
        .cornerRadius(8)
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
            // Header
            if let cadence = selectedCadence {
                Text("Allocate to \(cadence.rawValue)")
                    .font(.headline)
            }
            
            if let tileID = draggedTileID,
               let tileIndex = viewModel.questCadence.activityTiles.firstIndex(where: { $0.id == tileID }),
               let cadence = selectedCadence {
                
                let tile = viewModel.questCadence.activityTiles[tileIndex]
                
                Text("How many \(tile.activity.rawValue) for \(tile.source.rawValue) would you like to allocate?")
                    .multilineTextAlignment(.center)
                    .padding()
                
                // Number input
                Stepper("\(allocationAmount) Activities", value: $allocationAmount, in: 1...tile.unallocatedCount)
                    .padding()
                
                // If weekly/monthly/quarterly, show how many per period
                if cadence != .daily && cadence != .annual {
                    let periodText = cadencePeriodText(cadence)
                    let frequency = cadenceFrequency(cadence)
                    let perPeriod = max(1, Int(Double(allocationAmount) / Double(frequency)))
                    
                    Text("This is about \(perPeriod) per \(periodText)")
                        .font(.caption)
                        .foregroundColor(ThemeManager.textSecondary)
                }
                
                // Allocate button
                Button("Allocate") {
                    if let cadence = selectedCadence {
                        _ = viewModel.allocateActivities(tile: tile, cadence: cadence, count: allocationAmount)
                        showAllocationSheet = false
                        draggedTileID = nil
                    }
                }
                .padding()
                .background(ThemeManager.secondaryColor)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("Cancel") {
                    showAllocationSheet = false
                    draggedTileID = nil
                }
                .padding()
                .foregroundColor(ThemeManager.secondaryColor)
            }
        }
        .padding()
    }
    
    // Helper functions
    private func isCadenceEmpty(_ cadenceType: CadenceType) -> Bool {
        for tile in viewModel.questCadence.activityTiles {
            if let allocation = tile.allocations[cadenceType], allocation > 0 {
                return false
            }
        }
        return true
    }
    
    private func countTilesInCadence(_ cadenceType: CadenceType) -> Int {
        var count = 0
        for tile in viewModel.questCadence.activityTiles {
            if let allocation = tile.allocations[cadenceType], allocation > 0 {
                count += 1
            }
        }
        return count
    }
    
    private func cadencePeriodText(_ cadence: CadenceType) -> String {
        switch cadence {
        case .weekly: return "week"
        case .monthly: return "month"
        case .quarterly: return "quarter"
        default: return ""
        }
    }
    
    private func cadenceFrequency(_ cadence: CadenceType) -> Int {
        switch cadence {
        case .weekly: return 52 // 52 weeks in a year
        case .monthly: return 12 // 12 months
        case .quarterly: return 4 // 4 quarters
        default: return 1
        }
    }
}
