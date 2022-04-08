//
//  RejuvenateError.swift
//  Rejuvenate
//
//  Created by Ryan Chang on 2022-04-07.
//

import Foundation

enum RejuvenateError: LocalizedError {
    case failedReadingReminders
    case reminderHasNoDueDate
    
    var errorDescription: String? {
        switch self {
        case .failedReadingReminders:
            return NSLocalizedString("Failed to read reminders.", comment: "failed reading reminders error description")
        case .reminderHasNoDueDate:
            return NSLocalizedString("A reminder has no due date.", comment: "reminder has no due date error description")
        }
    }
}
