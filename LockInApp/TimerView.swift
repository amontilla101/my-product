//  Self Gemini AI & learn feature only
//
//  TimerView.swift
//  LockInApp
//
// Created: Alexa Montilla

import SwiftUI

struct TimerView: View {
    // Access session data to read remaining time and active status
    @EnvironmentObject var session: StudySession

    var body: some View {
        VStack(spacing: 16) {
            
            // Large Bold Digital Clock Readout
            Text(timeString(from: session.remainingSeconds > 0 ? session.remainingSeconds : session.durationSeconds))
                .font(.system(size: 56, weight: .bold, design: .rounded))
                .foregroundColor(.primary)

            // Hourglass Status Pill Indicator
            HStack(spacing: 8) {
                Image(systemName: session.isActive ? "hourglass.bottomhalf.filled" : "hourglass")
                    .font(.system(size: 18))
                    .foregroundColor(session.isActive ? .blue : .secondary)
                    .symbolEffect(.pulse, isActive: session.isActive) // Smooth animation when active

                Text(session.isActive ? "Focus mode active" : "Ready to focus")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(session.isActive ? .blue : .secondary)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 6)
            .background(session.isActive ? Color.blue.opacity(0.1) : Color(.systemGray6))
            .cornerRadius(20)

            Divider()
                .padding(.vertical, 4)

            // Session Duration Stepper Control (Adjusts timer length in 5-minute steps)
            Stepper(value: $session.durationSeconds, in: 5*60...120*60, step: 5*60) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Session Length")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(session.durationSeconds / 60) minutes")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
            }
        }
    }

    /// Helper function to format seconds into a mm:ss display string
    private func timeString(from seconds: Int) -> String {
        let m = seconds / 60
        let s = seconds % 60
        return String(format: "%02d:%02d", m, s)
    }
}
