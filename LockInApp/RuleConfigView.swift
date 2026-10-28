//  Self Gemini AI & learn feature only
//
//  RuleConfigView.swift
//  LockInApp
//
//  Created by Alexa montilla on 10/14/26.
//

import SwiftUI

/// View allowing users to configure duration rules for selected app restrictions.
struct RuleConfigView: View {
    // Title of the specific rule being configured
    let ruleTitle: String
    
    // State variable tracking the selected duration in minutes (defaults to 15)
    @State private var selectedMinutes: Int = 15
    
    // Environment property to dismiss/close this view
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Form {
            // Section containing the inline duration picker options
            Section(header: Text("Configure Duration")) {
                Picker("Duration", selection: $selectedMinutes) {
                    Text("5 minutes").tag(5)
                    Text("15 minutes").tag(15)
                    Text("30 minutes").tag(30)
                    Text("1 hour").tag(60)
                }
                .pickerStyle(.inline)
            }
            
            // Section containing the action button to save and exit
            Section {
                Button("Save Rule & Timer") {
                    // Here you can save selectedMinutes to UserDefaults or your SettingsStore
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.blue)
            }
        }
        .navigationTitle(ruleTitle)
    }
}
