//
//  CRMConnection.swift
//  Quest
//
//  Created by Ryan Bunke on 3/20/25.
//
import Foundation

struct CRMConnection {
    let userId: String
    let provider: CRMProvider
    var isConnected: Bool
    var lastSyncDate: Date?
    var authToken: String?
}

enum CRMProvider {
    case followUpBoss
    // Other CRMs could be added later
}

struct CRMSyncSettings {
    var syncPipeline: Bool
    var syncContacts: Bool
    var syncTasks: Bool
    var syncFrequency: SyncFrequency
}

enum SyncFrequency {
    case hourly
    case daily
    case manual
}