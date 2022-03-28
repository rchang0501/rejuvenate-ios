//
//  ReminderViewController+CellConfiguration.swift
//  Rejuvenate
//
//  Created by Ryan Chang on 2022-03-24.
//

import UIKit

// this extension contains all the content configuration ui elements
extension ReminderViewController {
    // container function for the default ui configuration of our list cells
    func defaultConfiguration(for cell: UICollectionViewListCell, at row: Row) -> UIListContentConfiguration {
        // style the content
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle) // row.textStyle changes based on the case
        contentConfiguration.image = row.image
        
        return contentConfiguration
    }
    
    // container function for the default ui configuration for headers
    func headerConfiguration(for cell: UICollectionViewListCell, with title: String) -> UIListContentConfiguration {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = title
        
        return contentConfiguration
    }
    
    // updates the text field's current text display value
    func titleConfiguration(for cell: UICollectionViewListCell, with title: String?) -> TextFieldContentView.Configuration {
        var contentConfiguration = cell.textFieldConfiguration() // .textFieldConfiguration() is an extension defined in TextFieldContentView.swift
        contentConfiguration.text = title // assign the text field text to whatever the title is at the moment (it will initially be the current title and can be deleted and altered to whatever else)
        contentConfiguration.onChange = { [weak self] title in
            self?.workingReminder.title = title // when change is detected, change the working title to the title in the textField 
        }
        return contentConfiguration
    }
    
    // sets the calendar edit view to the desired configuration
    func dateConfiguration(for cell: UICollectionViewListCell, with date: Date) -> DatePickerContentView.Configuration {
        var contentConfiguration = cell.datePickerConfiguration()
        contentConfiguration.date = date
        return contentConfiguration
    }
    
    // sets the notes edit view to the desired configuration
    func notesConfiguration(for cell: UICollectionViewListCell, with notes: String?) -> TextViewContentView.Configuration {
        var contentConfiguration = cell.textViewConfiguration()
        contentConfiguration.text = notes
        return contentConfiguration
    }
    
    // access the coresponding reminder text based on the cases
    func text(for row: Row ) -> String? {
        switch row {
        case .viewDate: return reminder.dueDate.dayText
        case .viewNotes: return reminder.notes
        case .viewTime: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
        case .viewTitle: return reminder.title
        default: return nil
        }
    }
}
