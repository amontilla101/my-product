//Self Gemini AI & learn feature only
//  PresetSessionView.swift
//  LockInApp
//
// Created: Alexa Montilla 10/14/26

import SwiftUI

// Detail view for a specific focus preset mode, displaying custom icons, titles, timers, and action buttons.
struct PresetSessionView: View {
    // Properties defining the preset's appearance and metadata
    let presetTitle: String
    let presetSubtitle: String
    let presetIcon: String
    let themeColor: Color

    // Global environment objects for managing shields and timer state
    @EnvironmentObject var settings: SettingsStore
    @EnvironmentObject var session: StudySession

    var body: some View {
        VStack(spacing: 28) {
            
            //Header section displaying the preset's icon, title, and subtitle
            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(themeColor.opacity(0.15))
                        .frame(width: 80, height: 80)
                    Image(systemName: presetIcon)
                        .font(.system(size: 36))
                        .foregroundColor(themeColor)
                }

                Text(presetTitle)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text(presetSubtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .padding(.top, 20)

            //Card wrapping the active countdown timer component
            VStack(spacing: 20) {
                TimerView()
            }
            .padding(24)
            .background(Color(.systemBackground))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
            .padding(.horizontal)

            // Control buttons to start or stop the preset session
            VStack(spacing: 12) {
                // Button to enable shields and start the session timer
                Button(action: {
                    settings.enableShields()
                    session.start()
                }) {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Start \(presetTitle)")
                    }
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(themeColor)
                    .foregroundColor(.white)
                    .cornerRadius(14)
                    .shadow(color: themeColor.opacity(0.3), radius: 6, x: 0, y: 3)
                }

                // Button to disable shields and stop the session
                Button(action: {
                    settings.disableShields()
                    session.stop()
                }) {
                    Text("Stop Session")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .foregroundColor(.red)
                        .cornerRadius(14)
                }
            }
            .padding(.horizontal, 24)

            Spacer()
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .navigationTitle(presetTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}
