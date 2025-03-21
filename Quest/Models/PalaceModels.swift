//
//  Palace.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//
import Foundation

struct Palace {
    let userId: String
    var gold: Int
    var items: [InventoryItem]
    var forge: Forge?
    var stable: Stable?
    var throneRoom: ThroneRoom
}

struct InventoryItem {
    let id: String
    let name: String
    let description: String
    let type: ItemType
    let rarity: ItemRarity
    let isEquipped: Bool
}

enum ItemType {
    case avatar
    case decoration
    case tool
    case weapon
    case armor
}

enum ItemRarity {
    case common
    case uncommon
    case rare
    case epic
    case legendary
}

struct Forge {
    var isUnlocked: Bool
    var recipes: [CraftingRecipe]
}

struct CraftingRecipe {
    let id: String
    let name: String
    let ingredients: [RecipeIngredient]
    let resultItem: InventoryItem
    let craftingTime: Int // In minutes
}

struct RecipeIngredient {
    let itemId: String
    let quantity: Int
}

struct Stable {
    var isUnlocked: Bool
    var animals: [Animal]
}

struct Animal {
    let id: String
    let name: String
    let species: AnimalSpecies
    let level: Int
    let value: Int
}

enum AnimalSpecies {
    case horse
    case dog
    case falcon
    // More animals
}

struct ThroneRoom {
    var courtMembers: [CourtMember]
    var decorations: [InventoryItem]
}

struct CourtMember {
    let id: String
    let name: String
    let role: CourtRole
    var isUnlocked: Bool
}

enum CourtRole {
    case jester
    case minstrel
    case wizard
    case knight
    case advisor
}