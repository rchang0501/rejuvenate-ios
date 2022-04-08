//
//  EKEventStore+AsyncFetch.swift
//  Rejuvenate
//
//  Created by Ryan Chang on 2022-04-07.
//

import Foundation
import EventKit

// class that asynchronously fetches reminders from EventKit
extension EKEventStore {
    func fetchReminders(matching predicate: NSPredicate) async throws -> [EKReminder] {
        try await withCheckedThrowingContinuation { continuation in
            fetchReminders(matching: predicate) { reminders in
                if let reminders = reminders {
                    continuation.resume(returning: reminders)
                } else {
                    continuation.resume(throwing: RejuvenateError.failedReadingReminders)
                }
            }
        }
    }
}
