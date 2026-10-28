//  Created by Alexa Montilla on 10/12/26.
//  Self Gemini AI & learn feature only
//
//  SettingsView.swift
//  LockInApp
//
//

import SwiftUI
import FamilyControls

struct SettingsView: View {
    @EnvironmentObject var settings: SettingsStore
    @State private var isPickerPresented = false

    var body: some View {
        Form {
            Section(header: Text("App Blocker Configuration")) {
                Button("Select Apps to Block") {
                    isPickerPresented = true
                }
                .familyActivityPicker(
                    isPresented: $isPickerPresented,
                    selection: $settings.activitySelection
                )
                
                Text("\(settings.activitySelection.applicationTokens.count) Apps Selected")
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Settings")
    }
}
