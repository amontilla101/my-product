//  Self Gemini AI & learn feature only
//
//  Main application entry point for LockIn. Initializes global state objects
//  (SettingsStore and StudySession) and injects them into the view environment
//  for downstream views.
//
// Created: Alexa Montilla

import SwiftUI

// The main entry point structure for the LockIn iOS application.
// Conforms to the SwiftUI `App` protocol and manages the root app lifecycle.
@main
struct LockInApp: App {
    // MARK: - Global Environment State Objects
    
    //Global settings store responsible for app shielding configurations, user preferences, and state persistence.
    @StateObject private var settings = SettingsStore()
    
    // Global study session controller managing focus timers, elapsed time tracking, and completion triggers.
    @StateObject private var session = StudySession()

    // MARK: - Scene Definition
    var body: some Scene {
        WindowGroup {
            // Sets ContentView as the root view of the application hierarchy
            ContentView()
                // Inject SettingsStore into the environment so any child view can access it
                .environmentObject(settings)
                // Inject StudySession into the environment for live timer updates across views
                .environmentObject(session)
        }
    }
}
