//  Self Gemini AI & learn feature only
//
//  SettingsStore.swift
//  LockInApp
//
// Create: Alexa Montilla on 10/14/26


import Foundation
import Combine
import FamilyControls
import ManagedSettings

/// Manages app shielding configurations, user screen time authorizations, and local storage persistence.
final class SettingsStore: ObservableObject {
    // Holds selected apps/categories chosen from Apple's native picker
    @Published var activitySelection = FamilyActivitySelection() {
        didSet {
            saveSelection()
        }
    }
    
    private let store = ManagedSettingsStore()
    private let userDefaultsKey = "SavedFamilyActivitySelection"

    init() {
        requestAuthorization()
        loadSelection()
    }

    /// Request permission from iOS to control Screen Time
    func requestAuthorization() {
        Task {
            do {
                try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
            } catch {
                print("Failed to authorize Family Controls: \(error.localizedDescription)")
            }
        }
    }

    /// Turn on app shields for selected apps and block web content
    func enableShields() {
        let appTokens = activitySelection.applicationTokens
        let categoryTokens = activitySelection.categoryTokens
         
        // 1. Block chosen app tokens and categories
        if !appTokens.isEmpty || !categoryTokens.isEmpty {
            store.shield.applications = appTokens
            store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(categoryTokens)
        }
         
        // 2. 🌐 System-wide Web Content Shield (Blocks Safari & web browsing)
        store.webContent.blockedByFilter = WebContentSettings.FilterPolicy.all()
    }

    /// Turn off all shields and restore Safari / web access
    func disableShields() {
        store.shield.applications = nil
        store.shield.applicationCategories = nil
         
        // Lift Safari / Web shield
        store.webContent.blockedByFilter = nil
    }

    // MARK: - Persistence
    
    /// Saves the user's selected blocked apps to local storage
    private func saveSelection() {
        if let encoded = try? PropertyListEncoder().encode(activitySelection) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }

    /// Loads the previously saved blocked apps from local storage
    private func loadSelection() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decoded = try? PropertyListDecoder().decode(FamilyActivitySelection.self, from: data) {
            self.activitySelection = decoded
        }
    }
    
}
