//
//  Reminder.swift
//  Rejuvenate
//
//  Created by Ryan Chang on 2022-03-17.
//

import Foundation

struct Reminder {
    // don't have to create an initializer for these properties
    // swift provides a memberwise intiatizer that automatically initailizes properties of a structure whether or not they have default values
    var title: String
    var dueDate: Date
    var notes: String? = nil
    var isComplete: Bool = false
}

// #if DEBUG flag prevents this block of code from compiling during release --> this is used for testing or storing sample data
#if DEBUG
extension Reminder {
    static var sampleData = [
        Reminder(title: "Apply Artemisia Cleanser", dueDate: Date().addingTimeInterval(800.0), notes: "Use just a dime size amount"),
        Reminder(title: "Apply Niacinamide Serum", dueDate: Date().addingTimeInterval(14000.0), notes: "Fill up the eye dropper and apply to cheeks and t-zone", isComplete: true),
        Reminder(title: "Apply Centella Moisturizer", dueDate: Date().addingTimeInterval(24000.0), notes: "Ensure entire face is covered"),
        Reminder(title: "Apply Artemisia Cleanser", dueDate: Date().addingTimeInterval(3200.0), notes: "Use just a dime size amount", isComplete: true),
        Reminder(title: "Apply Niacinamide Serum", dueDate: Date().addingTimeInterval(60000.0), notes: "Fill up the eye dropper and apply to cheeks and t-zone"),
        Reminder(title: "Apply Mandelic Acid Exfoliant", dueDate: Date().addingTimeInterval(72000.0), notes: "Take a cotton pad, drip as a line, swipe along skin"),
        Reminder(title: "Apply Centella Moisturizer", dueDate: Date().addingTimeInterval(83000.0), notes: "Ensure entire face is covered"),
        Reminder(title: "Apply Artemisia Mask", dueDate: Date().addingTimeInterval(101000.0),  notes: "Use just a dime size amount and keep on for at least 5 minutes"),
        Reminder(title: "Apply Centella Moisturizer", dueDate: Date().addingTimeInterval(83000.0), notes: "Ensure entire face is covered")
    ]
}
#endif
