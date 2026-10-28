// Self Gemini AI & learn feature only
//
//  EndSessionView.swift
//  LockInApp
//
// Created: Alexa Montilla

import SwiftUI

// View shown when a study break timer ends, prompting the user to get back to work.
struct EndSessionView: View {
    // Accesses the global study session state
    @EnvironmentObject var session: StudySession

    var body: some View {
        VStack(spacing: 24) {
            
            // Header title indicating the break is over
            Text("Break Over")
                .font(.largeTitle)
                .bold()

            // Instructional text reminding the user to study
            Text("Time to get back to studying.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            // Button to dismiss the screen and resume the normal session
            Button(action: {
                session.didEnd = false
            }) {
                Text("Resume")
                    .frame(minWidth: 140)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            // Button to snooze the break for 5 more minutes
            Button(action: {
                session.didEnd = false
            }) {
                Text("Snooze 5 min")
            }
        }
        .padding()
    }
}
