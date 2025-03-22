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
    @State private var showTip = false
    @AppStorage("hasShownQuestTip") private var hasShownQuestTip = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Quest Manager")
                .font(ThemeManager.medievalTitle())
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Drag activities into different cadence boxes")
                .font(ThemeManager.medievalBody())
                .multilineTextAlignment(.center)
                .foregroundColor(ThemeManager.textSecondary)
                .padding(.horizontal)
            
            // Gold bonus card at top
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
                    
                    
                    // Add new activity button
                    // New Quest button (renamed from New Activity)
                    Button(action: {
                        viewModel.resetActivitySelections()
                        viewModel.currentStep = 4 // Set to go to Income Sources view
                    }) {
                        VStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 24))
                                .foregroundColor(ThemeManager.accentColor)
                            
                            Text("New Quest") // Changed from "New Activity"
                                .font(.caption)
                        }
                        .frame(width: 100, height: 70)
                        .background(ThemeManager.backgroundSecondary)
                        .cornerRadius(8)
                    }

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
                }
                .padding()
            }
            .background(ThemeManager.backgroundSecondary.opacity(0.5))
            .cornerRadius(10)
            .padding(.horizontal)
            // Replace the end of your body View with this:
            // At the end of the body View:
            }
            .padding(.vertical)
            .overlay(
                Group {
                    if showTip {
                        GeometryReader { geometry in
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Start here!")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Text("Tap to create a new quest")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                
                                Button("Got it") {
                                    showTip = false
                                    hasShownQuestTip = true
                                }
                                .font(.caption.bold())
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.white)
                                .foregroundColor(ThemeManager.secondaryColor)
                                .cornerRadius(12)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(ThemeManager.secondaryColor)
                            )
                            .position(x: 180, y: geometry.size.height - 70)
                        }
                        .zIndex(100) // Ensure it's above everything
                    }
                }
            )
            .sheet(isPresented: $showAllocationSheet) {
                allocationSheet()
            }
            .onAppear {
                // Show tip if this is the first time
                if !hasShownQuestTip {
                    // Small delay to make sure view is fully loaded
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showTip = true
                    }
                }
            }
        .sheet(isPresented: $showAllocationSheet) {
            allocationSheet()
        }
        .onAppear {
            // Show tip if this is the first time
            if !hasShownQuestTip {
                // Small delay to make sure view is fully loaded
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showTip = true
                }
            }
        }
    }
    
    private func cadenceBox(for cadenceType: CadenceType) -> some View {
        Button(action: {
            if viewModel.selectedTile != nil {
                selectedCadence = cadenceType
                if let tile = viewModel.selectedTile {
                    allocationAmount = viewModel.suggestedAllocation(tile: tile, cadence: cadenceType)
                }
                showAllocationSheet = true
            }
        }) {
            VStack(alignment: .leading) {
                HStack {
                    Text(cadenceType.rawValue)
                        .font(ThemeManager.medievalHeading())
                    
                    Spacer()
                    
                    // Display gold bonus in top right
                    if !isCadenceEmpty(cadenceType) {
                        HStack {
                            Image(systemName: "coins")
                                .foregroundColor(ThemeManager.accentColor)
                                .font(.caption)
                            
                            let tileCount = countTilesInCadence(cadenceType)
                            let goldAmount = tileCount >= 5 ? 10 : (5 * tileCount)
                            
                            Text("\(goldAmount)/day")
                                .font(.caption)
                                .foregroundColor(ThemeManager.accentColor)
                                .fontWeight(.bold)
                        }
                        .padding(6)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(ThemeManager.backgroundPrimary.opacity(0.7))
                        )
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
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(isCadenceEmpty(cadenceType)
                          ? Color.gray.opacity(0.2)
                          : ThemeManager.backgroundSecondary)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(viewModel.selectedTile != nil ? ThemeManager.accentColor.opacity(0.5) : Color.clear,
                            style: StrokeStyle(lineWidth: 2, dash: [5]))
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func activityTileView(_ tile: ActivityTile) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            // Format as Activity: Source
            Text("\(tile.activity.rawValue): \(tile.source.rawValue)")
                .font(.caption.bold())
                .foregroundColor(ThemeManager.textPrimary)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
            
            // Format as Remaining: X
            Text("Remaining: \(tile.unallocatedCount)")
                .font(.caption)
                .foregroundColor(ThemeManager.accentColor)
        }
        .padding(8)
        .frame(width: 120, height: 70) // Slightly wider to accommodate longer text
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
            // Format as Activity: Source
            Text("\(tile.activity.rawValue): \(tile.source.rawValue)")
                .font(.caption.bold())
                .foregroundColor(ThemeManager.textPrimary)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
            
            // Show allocated count
            Text("\(count) allocated")
                .font(.caption)
                .foregroundColor(ThemeManager.accentColor)
        }
        .padding(8)
        .frame(width: 120, height: 70) // Slightly wider to accommodate longer text
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
