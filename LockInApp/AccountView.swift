//  Created: Alexa montilla on 10/19/26.
//
//
//  AccountView.swift
//  LockInApp
//

//Page for user account. Page has information about user's information

import SwiftUI

struct AccountView: View {
    @State private var userName: String = "Jane Doe"
    @State private var userEmail: String = "janedoe101@gmail.com"
    @State private var userPhone: String = "(555)-019-2834"
    @State private var selectedLanguage: String = "English"
    @State private var notificationsEnabled: Bool = true
    @State private var strictModeEnabled: Bool = false

    // User has the option to change languages
    let languages = ["English", "Spanish", "French", "German", "Chinese", "Japanese"]
    
    // Section: Body page for user account
    var body: some View {
        Form {
            // Profile Header
            Section {
                HStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .fill(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 70, height: 70)
                        
                        Image(systemName: "person.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(userName)
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        Text("Student / Educator")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, 8)
            }

            // Personal Information
            Section(header: Text("Personal Information")) {
                HStack {
                    Text("Name")
                    Spacer()
                    TextField("Name", text: $userName)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.secondary)
                }

                HStack {
                    Text("Phone")
                    Spacer()
                    TextField("Phone", text: $userPhone)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.secondary)
                }

                HStack {
                    Text("Email")
                    Spacer()
                    TextField("Email", text: $userEmail)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.secondary)
                }
            }

            // Security & Preferences
            Section(header: Text("Security & Preferences")) {
                NavigationLink(destination: Text("Change Password View").navigationTitle("Change Password")) {
                    HStack {
                        Image(systemName: "key.fill")
                            .foregroundColor(.blue)
                        Text("Change Password")
                    }
                }

                Picker(selection: $selectedLanguage, label:
                    HStack {
                        Image(systemName: "globe")
                            .foregroundColor(.blue)
                        Text("Language")
                    }
                ) {
                    ForEach(languages, id: \.self) { lang in
                        Text(lang).tag(lang)
                    }
                }

                Toggle(isOn: $notificationsEnabled) {
                    HStack {
                        Image(systemName: "bell.fill")
                            .foregroundColor(.blue)
                        Text("Session Reminders")
                    }
                }

                Toggle(isOn: $strictModeEnabled) {
                    HStack {
                        Image(systemName: "lock.shield.fill")
                            .foregroundColor(.blue)
                        Text("Strict Lockdown Mode")
                    }
                }
            }

            // Settings & System
            Section(header: Text("Settings")) {
                NavigationLink(destination: SettingsView()) {
                    HStack {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.blue)
                        Text("App Shielding Settings")
                    }
                }
            }

            // Logout Option (Red)
            Section {
                Button(action: {
                    // Log out functionality
                }) {
                    HStack {
                        Spacer()
                        Text("Log Out")
                            .fontWeight(.bold)
                            .foregroundColor(.red) //Red styled Log Out button
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("Account")
    }
}
