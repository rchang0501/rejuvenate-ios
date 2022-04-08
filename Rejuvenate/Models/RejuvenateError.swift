//
//  RejuvenateError.swift
//  Rejuvenate
//
//  Created by Ryan Chang on 2022-04-07.
//

import Foundation

enum RejuvenateError: LocalizedError {
    case failedReadingReminders
    
    var errorDescription: String? {
        return NSLocalizedString("Failed to read reminders.", comment: "failed reading reminders error description")
    }
}
