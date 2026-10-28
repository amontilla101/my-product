//  Self Gemini AI & learn feature only
//  ContentView.swift
//  LockInApp
//
//  Main user interface for LockIn, orchestrating focus session triggers,
//  app blocking shields, monitoring previews, detox metrics, screen time breakdown,
//  and achievement badges.
//
// Created: Alexa Montilla 

import SwiftUI

// Main dashboard view representing the core user hub of the LockIn application.
// Manages navigation, state objects, productivity summaries, countdown widgets, and feature cards.
struct ContentView: View {
    // MARK: - Environment & State Objects
    
    // Global settings store managing app shielding states, user preferences, and configurations.
    @EnvironmentObject var settings: SettingsStore
    
    // Active session state object tracking study timers and completion triggers.
    @EnvironmentObject var session: StudySession

    // MARK: - UI Constants & Styling Properties
    
    // Instagram-inspired vibrant multi-stop linear gradient used for avatars, buttons, and glowing highlights.
    private let instagramGradient = LinearGradient(
        colors: [
            Color(red: 0.51, green: 0.23, blue: 0.71), // Purple
            Color(red: 0.89, green: 0.18, blue: 0.36), // Pink-Red
            Color(red: 0.96, green: 0.38, blue: 0.25), // Orange
            Color(red: 1.00, green: 0.86, blue: 0.50)  // Yellow
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // MARK: - Main Body View
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 22) {
                    
                    // MARK: - Header (Instagram Story Ring Profile + Greeting)
                    // Displays the user profile avatar with an Instagram story ring and navigates to the Account view.
                    NavigationLink(destination: AccountView()) {
                        HStack(spacing: 14) {
                            // Instagram Story Ring Avatar Container
                            ZStack {
                                Circle()
                                    .fill(instagramGradient)
                                    .frame(width: 52, height: 52)

                                Circle()
                                    .fill(Color(.systemGroupedBackground))
                                    .frame(width: 47, height: 47)

                                ZStack {
                                    Circle()
                                        .fill(LinearGradient(colors: [.purple.opacity(0.8), .indigo], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    Image(systemName: "person.fill")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                }
                                .frame(width: 42, height: 42)
                            }

                            // Personalized Greeting + User Name Text Block
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Welcome back,")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text("Alexa Montilla")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                            }

                            Spacer()

                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.horizontal, 4)
                    .padding(.top, 8)

                    // MARK: - Productivity Overview Card (Opal Glass Glow)
                    // Showcases accumulated focus hours and weekly productivity percentage increases.
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("You stayed productive")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                           
                            Spacer()
                           
                            Image(systemName: "sparkles")
                                .foregroundColor(.purple)
                                .font(.subheadline)
                        }

                        // Large formatted hours and minutes counter with gradient text styling
                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Text("6")
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                                .foregroundStyle(instagramGradient)
                            Text("hrs")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.secondary)

                            Text("17")
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                                .foregroundStyle(instagramGradient)
                                .padding(.leading, 8)
                            Text("mins")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.secondary)
                        }

                        // Weekly trend comparison indicator
                        HStack {
                            Image(systemName: "chart.line.uptrend.xyaxis.circle.fill")
                                .font(.title3)
                                .foregroundStyle(instagramGradient)

                            Text("+12% increase from last week")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemBackground))
                    .cornerRadius(22)
                    .shadow(color: Color.purple.opacity(0.08), radius: 10, x: 0, y: 4)

                    // MARK: - Main Timer Display Card
                    // Wraps the active countdown timer interface component.
                    VStack(spacing: 20) {
                        TimerView()
                    }
                    .padding(20)
                    .background(Color(.systemBackground))
                    .cornerRadius(22)
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)

                    // MARK: - Main Control Buttons
                    // Action buttons to initiate study sessions with app shielding or prematurely stop them.
                    VStack(spacing: 12) {
                        // Triggers system app shields and starts the focus timer session
                        Button(action: {
                            settings.enableShields()
                            session.start()
                        }) {
                            HStack {
                                Image(systemName: "lock.fill")
                                Text("Start Study & Block Apps")
                            }
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(instagramGradient)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                            .shadow(color: Color.purple.opacity(0.3), radius: 8, x: 0, y: 4)
                        }

                        // Disables app shields and stops the current timer session
                        Button(action: {
                            settings.disableShields()
                            session.stop()
                        }) {
                            Text("Stop Session")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(Color.red.opacity(0.1))
                                .foregroundColor(.red)
                                .cornerRadius(16)
                        }
                    }

                    // MARK: - Focus Presets Section (Single Scroll Carousel)
                    // Horizontal scrollable card container presenting the 6 core focus mode configurations.
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Text("Focus Presets")
                                .font(.headline)
                                .fontWeight(.bold)
                           
                            Spacer()
                           
                            Text("Swipe")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 14) {
                                // Preset 1: Anti-Doom Scrolling
                                NavigationLink(destination: PresetSessionView(
                                    presetTitle: "Anti-Doom Scrolling",
                                    presetSubtitle: "Limits continuous feed scrolling during study breaks.",
                                    presetIcon: "iphone.slash",
                                    themeColor: .orange
                                )) {
                                    OpalPresetCard(
                                        title: "Anti-Doom Scrolling",
                                        description: "Limits feed scrolling",
                                        icon: "iphone.slash",
                                        gradient: LinearGradient(colors: [.orange, .pink], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                }

                                // Preset 2: Block All Apps
                                NavigationLink(destination: PresetSessionView(
                                    presetTitle: "Block All Apps",
                                    presetSubtitle: "Complete lockdown of all distracting apps.",
                                    presetIcon: "shield.fill",
                                    themeColor: .blue
                                )) {
                                    OpalPresetCard(
                                        title: "Block All Apps",
                                        description: "Full app restriction",
                                        icon: "shield.fill",
                                        gradient: LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                }

                                // Preset 3: Reading Time
                                NavigationLink(destination: PresetSessionView(
                                    presetTitle: "Reading Time",
                                    presetSubtitle: "Focus entirely on coursework and reading materials.",
                                    presetIcon: "book.fill",
                                    themeColor: .green
                                )) {
                                    OpalPresetCard(
                                        title: "Reading Time",
                                        description: "Quiet study focus",
                                        icon: "book.fill",
                                        gradient: LinearGradient(colors: [.green, .teal], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                }

                                // Preset 4: Cleaning Time
                                NavigationLink(destination: PresetSessionView(
                                    presetTitle: "Cleaning Time",
                                    presetSubtitle: "Stay focused on chores without phone distractions.",
                                    presetIcon: "bubbles.and.sparkles.fill",
                                    themeColor: .teal
                                )) {
                                    OpalPresetCard(
                                        title: "Cleaning Time",
                                        description: "Chore lockdown",
                                        icon: "bubbles.and.sparkles.fill",
                                        gradient: LinearGradient(colors: [.teal, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                }

                                // Preset 5: We Outside
                                NavigationLink(destination: PresetSessionView(
                                    presetTitle: "We Outside",
                                    presetSubtitle: "Disconnect completely for outdoor or offline breaks.",
                                    presetIcon: "sun.max.fill",
                                    themeColor: .purple
                                )) {
                                    OpalPresetCard(
                                        title: "We Outside",
                                        description: "Offline recharge",
                                        icon: "sun.max.fill",
                                        gradient: LinearGradient(colors: [.purple, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                }

                                // Preset 6: Artist Mode
                                NavigationLink(destination: PresetSessionView(
                                    presetTitle: "Artist Mode",
                                    presetSubtitle: "Uninterrupted creative time for design and art.",
                                    presetIcon: "paintpalette.fill",
                                    themeColor: .indigo
                                )) {
                                    OpalPresetCard(
                                        title: "Artist Mode",
                                        description: "Creative flow mode",
                                        icon: "paintpalette.fill",
                                        gradient: LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                }
                            }
                        }
                    }

                    // MARK: - Feature Card: App Monitoring
                    // Shows target apps currently under surveillance and provides a shortcut to configure rules.
                    VStack(alignment: .leading, spacing: 14) {
                        Text("App Monitoring")
                            .font(.headline)
                            .fontWeight(.bold)
                       
                        HStack(spacing: 16) {
                            NavigationLink(destination: SettingsView().environmentObject(settings)) {
                                ZStack {
                                    Circle()
                                        .strokeBorder(instagramGradient, style: StrokeStyle(lineWidth: 2, dash: [4]))
                                        .frame(width: 52, height: 52)
                                    Image(systemName: "plus")
                                        .font(.title3)
                                        .foregroundStyle(instagramGradient)
                                }
                            }

                            AppIconView(name: "Instagram", color: .pink, icon: "camera.fill")
                            AppIconView(name: "Facebook", color: .blue, icon: "f.circle.fill")
                            AppIconView(name: "YouTube", color: .red, icon: "play.rectangle.fill")
                        }
                    }
                    .padding(18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemBackground))
                    .cornerRadius(22)
                    .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 3)

                    // MARK: - Feature Card: Time Detox Monitor
                    // Visual bar graph tracking total time spent away from restricted apps over weekdays.
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Your Time Detox")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("Time spent away from distracting apps")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text("4.5 hrs")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                        }

                        VStack(spacing: 8) {
                            HStack(alignment: .bottom, spacing: 12) {
                                DetoxBar(day: "Mon", hours: 2.0, maxHeight: 6.0)
                                DetoxBar(day: "Tue", hours: 4.5, maxHeight: 6.0)
                                DetoxBar(day: "Wed", hours: 3.0, maxHeight: 6.0)
                                DetoxBar(day: "Thu", hours: 5.2, maxHeight: 6.0)
                                DetoxBar(day: "Fri", hours: 1.5, maxHeight: 6.0)
                            }
                            .frame(height: 100)

                            Divider()

                            HStack {
                                Text("0h")
                                Spacer()
                                Text("2h")
                                Spacer()
                                Text("4h")
                                Spacer()
                                Text("6h+")
                            }
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        }
                    }
                    .padding(18)
                    .background(Color(.systemBackground))
                    .cornerRadius(22)
                    .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 3)

                    // MARK: - Feature Card: Screen Time Breakdown
                    // Displays fractional usage bar graphs and duration rows for individual apps.
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Screen Time")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("Daily app usage summary")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text("3h 11m")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                        }

                        // Proportionate gradient usage summary bar
                        GeometryReader { geometry in
                            HStack(spacing: 3) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(LinearGradient(colors: [.purple, .pink], startPoint: .leading, endPoint: .trailing))
                                    .frame(width: geometry.size.width * 0.42)

                                RoundedRectangle(cornerRadius: 4)
                                    .fill(LinearGradient(colors: [.blue, .cyan], startPoint: .leading, endPoint: .trailing))
                                    .frame(width: geometry.size.width * 0.24)

                                RoundedRectangle(cornerRadius: 4)
                                    .fill(LinearGradient(colors: [.red, .orange], startPoint: .leading, endPoint: .trailing))
                                    .frame(width: geometry.size.width * 0.17)

                                RoundedRectangle(cornerRadius: 4)
                                    .fill(LinearGradient(colors: [.gray.opacity(0.4), .gray.opacity(0.2)], startPoint: .leading, endPoint: .trailing))
                                    .frame(width: geometry.size.width * 0.17)
                            }
                        }
                        .frame(height: 12)
                        .cornerRadius(6)

                        Divider()

                        VStack(spacing: 12) {
                            ScreenTimeAppRow(
                                appName: "Instagram",
                                durationText: "1h 21m",
                                percentageRatio: 0.85,
                                iconName: "camera.fill",
                                gradientColors: [.purple, .pink]
                            )

                            ScreenTimeAppRow(
                                appName: "Facebook",
                                durationText: "45m",
                                percentageRatio: 0.50,
                                iconName: "f.circle.fill",
                                gradientColors: [.blue, .cyan]
                            )

                            ScreenTimeAppRow(
                                appName: "YouTube",
                                durationText: "32m",
                                percentageRatio: 0.35,
                                iconName: "play.rectangle.fill",
                                gradientColors: [.red, .orange]
                            )
                        }
                    }
                    .padding(18)
                    .background(Color(.systemBackground))
                    .cornerRadius(22)
                    .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 3)

                    // MARK: - Feature Card: Focus Achievements
                    // Horizontal badge list showcasing user achievements earned through focused time blocks.
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Focus Milestones")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("Badges earned through total time locked in")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text("3 Unlocked")
                                .font(.caption)
                                .fontWeight(.bold)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(Color.orange.opacity(0.15))
                                .foregroundColor(.orange)
                                .cornerRadius(12)
                        }

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                AchievementBadgeView(
                                    title: "3h Focused",
                                    subtitle: "Completed",
                                    icon: "bolt.shield.fill",
                                    gradientColors: [.orange, .yellow],
                                    isUnlocked: true
                                )

                                AchievementBadgeView(
                                    title: "Deep Diver",
                                    subtitle: "2h Session",
                                    icon: "timer",
                                    gradientColors: [.purple, .blue],
                                    isUnlocked: true
                                )

                                AchievementBadgeView(
                                    title: "3 Day Streak",
                                    subtitle: "Consistent",
                                    icon: "flame.fill",
                                    gradientColors: [.red, .orange],
                                    isUnlocked: true
                                )

                                AchievementBadgeView(
                                    title: "10h Master",
                                    subtitle: "Locked",
                                    icon: "lock.fill",
                                    gradientColors: [.gray, .secondary],
                                    isUnlocked: false
                                )
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .padding(18)
                    .background(Color(.systemBackground))
                    .cornerRadius(22)
                    .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 3)

                }
                .padding(.horizontal, 16)
                .padding(.bottom, 30)
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .fullScreenCover(isPresented: $session.didEnd) {
                EndSessionView()
                    .environmentObject(session)
                    .environmentObject(settings)
            }
        }
    }
}

// MARK: - Opal Style Preset UI Card Component
/// A reusable card component styled after Opal's preset launcher cards.
/// Displays a colored gradient icon badge, title, subtitle description, and navigation indicator.
struct OpalPresetCard: View {
    let title: String
    let description: String
    let icon: String
    let gradient: LinearGradient

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                ZStack {
                    Circle()
                        .fill(gradient)
                        .frame(width: 38, height: 38)
                    Image(systemName: icon)
                        .foregroundColor(.white)
                        .font(.subheadline)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                Text(description)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }
        .padding(14)
        .frame(width: 165, height: 110)
        .background(Color(.systemBackground))
        .cornerRadius(18)
        .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 3)
    }
}

// MARK: - Helper View: App Icon Badge
/// Renders a circular app icon container with a custom SF Symbol and app name label.
struct AppIconView: View {
    let name: String
    let color: Color
    let icon: String

    var body: some View {
        VStack(spacing: 4) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 52, height: 52)
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(color)
            }
            Text(name)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Helper View: Detox Graph Bar
/// Renders an individual column bar for the weekly time detox bar chart, scaled proportionally by hours.
struct DetoxBar: View {
    let day: String
    let hours: Double
    let maxHeight: Double

    var body: some View {
        VStack(spacing: 4) {
            Spacer()
            RoundedRectangle(cornerRadius: 6)
                .fill(LinearGradient(colors: [.purple, .blue], startPoint: .top, endPoint: .bottom))
                .frame(height: CGFloat((hours / maxHeight) * 80))
            Text(day)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Helper View: Achievement Badge Component
/// Represents an unlockable milestone badge item, dynamically altering colors and shadows based on unlock status.
struct AchievementBadgeView: View {
    let title: String
    let subtitle: String
    let icon: String
    let gradientColors: [Color]
    let isUnlocked: Bool

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(
                        isUnlocked ?
                        LinearGradient(colors: gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing) :
                        LinearGradient(colors: [.gray.opacity(0.2), .gray.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .frame(width: 64, height: 64)
                    .shadow(color: isUnlocked ? gradientColors[0].opacity(0.3) : .clear, radius: 6, x: 0, y: 3)

                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(isUnlocked ? .white : .gray)
            }

            VStack(spacing: 2) {
                Text(title)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(isUnlocked ? .primary : .secondary)

                Text(subtitle)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .frame(width: 85)
    }
}

// MARK: - Helper View: Screen Time App Row
/// Renders a breakdown row for an individual app showing its icon, name, duration text, and proportional usage bar.
struct ScreenTimeAppRow: View {
    let appName: String
    let durationText: String
    let percentageRatio: CGFloat
    let iconName: String
    let gradientColors: [Color]

    var body: some View {
        VStack(spacing: 6) {
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: iconName)
                        .font(.caption)
                        .foregroundColor(gradientColors[0])
                        .frame(width: 26, height: 26)
                        .background(gradientColors[0].opacity(0.15))
                        .clipShape(Circle())

                    Text(appName)
                        .font(.subheadline)
                        .fontWeight(.medium)
                }

                Spacer()

                Text(durationText)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color(.systemGray6))
                        .frame(height: 6)

                    RoundedRectangle(cornerRadius: 3)
                        .fill(LinearGradient(colors: gradientColors, startPoint: .leading, endPoint: .trailing))
                        .frame(width: geometry.size.width * percentageRatio, height: 6)
                }
            }
            .frame(height: 6)
        }
    }
}
