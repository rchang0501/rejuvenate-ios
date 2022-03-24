//
//  ReminderViewController+Section.swift
//  Rejuvenate
//
//  Created by Ryan Chang on 2022-03-24.
//

import Foundation

extension ReminderViewController {
    enum Section: Int, Hashable { // data source uses hash values to determine changes in data
        case view // data source supplies information in a single view section which is why we need to make these seciotns
        case title
        case date
        case notes
        
        var name: String {
            switch self {
            case .view: return ""
            case .title:
                return NSLocalizedString("Title", comment: "Title section name")
            case .date:
                return NSLocalizedString("Date", comment: "Date section name")
            case .notes:
                return NSLocalizedString("Notes", comment: "Notes section name")
            }
        }
    }
}
