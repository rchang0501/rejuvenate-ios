//
//  ReminderStore.swift
//  Rejuvenate
//
//  Created by Ryan Chang on 2022-04-07.
//

import Foundation
import EventKit

class ReminderStore {
    static let shared = ReminderStore()
    
    private let ekStore = EKEventStore()
    
    var isAvailable: Bool {
        EKEventStore.authorizationStatus(for: .reminder) == .authorized
    }
    
    func requestAccess() async throws {
        let status = EKEventStore.authorizationStatus(for: .reminder)
        
        switch status {
        case .authorized:
            return
        case .restricted:
            throw RejuvenateError.accessRestricted
        case .notDetermined:
            let accessGranted = try await ekStore.requestAccess(to: .reminder)
            guard accessGranted else {
                throw RejuvenateError.accessDenied
            }
        case .denied:
            throw RejuvenateError.accessDenied
        @unknown default:
            throw RejuvenateError.unknown
        }
    }
    
    func readAll() async throws -> [Reminder] {
        guard isAvailable else {
            throw RejuvenateError.accessDenied
        }
        
        let predicate = ekStore.predicateForReminders(in: nil)
        let ekReminders = try await ekStore.fetchReminders(matching: predicate)
        let reminders: [Reminder] = try ekReminders.compactMap { ekReminder in
            do {
                return try Reminder(with: ekReminder)
            } catch RejuvenateError.reminderHasNoDueDate {
                return nil
            }
        }
        
        return reminders
    }
}

