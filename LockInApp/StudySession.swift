//  Self Gemini AI & learn feature only
//  StudySession.swift
//  LockInApp
//
// Created: Alexa Montilla

import Foundation
import Combine
import ManagedSettings // Required for ManagedSettingsStore

final class StudySession: ObservableObject {
    @Published var durationSeconds: Int = 25 * 60
    @Published private(set) var remainingSeconds: Int = 0
    @Published var isActive: Bool = false
    @Published var didEnd: Bool = false

    private var timerCancellable: AnyCancellable?

    func start() {
        remainingSeconds = durationSeconds
        isActive = true
        didEnd = false

        timerCancellable?.cancel()
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.tick()
            }
    }

    func stop() {
        isActive = false
        timerCancellable?.cancel()
        timerCancellable = nil
    }

    private func tick() {
        guard remainingSeconds > 0 else {
            endSession()
            return
        }
        remainingSeconds -= 1
    }

    private func endSession() {
        stop()
        didEnd = true
        ManagedSettingsStore().shield.applications = nil
        ManagedSettingsStore().shield.applicationCategories = nil
    }
}
