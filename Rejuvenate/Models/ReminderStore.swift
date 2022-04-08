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
}
