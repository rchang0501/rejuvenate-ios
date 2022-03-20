//
//  ReminderListViewController+DataSource.swift
//  Rejuvenate
//
//  Created by Ryan Chang on 2022-03-20.
//

import UIKit

// because of the flaw of view controllers needing to do a lot of different things, these files can get very large
// thus, it is good practice to break them down into multiplce components that handle specific features
// we break them down into separate files by making extensions to the main view controller file
// this specific extention handles the data rather than the set up of the ui
extension ReminderListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID> // this is basically just assigning the diffable data source type to a new alias called DataSource. diffable data updates and animates the ui when data changes -> basically just live data
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Reminder.ID> // the diffable data source manages data using snapshots -> snapshots represent the state of the data at a certain point in time (like context) -> will be applying the snap shot to display data in the ui
    
    func updateSnapshot(reloading ids: [Reminder.ID] = []) { // initializing to empty array allows the function to be called without passing in any parameters
        var snapShot = Snapshot() // new empty snapshot variable
        snapShot.appendSections([0]) // add the section to it
        snapShot.appendItems(reminders.map{$0.id}) // map returns a new array containing the titles ($0 means the first instance in the sampleData array)
        if !ids.isEmpty {
            snapShot.reloadItems(ids) // this method tells the snapshot which reminders the user changed
        }
        dataSource.apply(snapShot) // applying the snapshot reflects the changes in the ui
    }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID) {
        // retrieve sample data
        let reminder = reminder(for: id)
        
        // use the cell's content creation to assign the main contnet of the cell
        var contentConfiguration = cell.defaultContentConfiguration() // retrieve cell's default config
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
        
        // intitialize and assign the done button to the cell
        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        doneButtonConfiguration.tintColor = .rejuvenateListCellDoneButtonTint
        cell.accessories = [.customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed: .always)] // accessories is an additional property of the collection view's cell where we can pass in a custom view as well as when it is displayed
        
        // create the cell background style
        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfiguration.backgroundColor = .rejuvenateListCellBackground
        cell.backgroundConfiguration = backgroundConfiguration
    }
    
    // function that changes the isComplete state of a reminder --> called when the done button is tapped 
    func completeReminder(with id: Reminder.ID){
        var reminder = reminder(for: id)
        reminder.isComplete.toggle() // toggle changes the value to false is currently true and true if currently false
        update(reminder, with: id) // update the reminder object
        updateSnapshot(reloading: [id]) // update the snapshot so the datasource is up to date so the ui is updated
    }
    
    // this configures the button on the side of each cell to toggle whether or not the reminder was completed
    private func doneButtonConfiguration(for reminder: Reminder) -> UICellAccessory.CustomViewConfiguration {
        // create and set up the circle image for the button
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        
        // create and set up the button
        let button = ReminderDoneButton()
        button.addTarget(self, action: #selector(didPressDoneButton(_:)), for: .touchUpInside) // this links the touchUpInside even that trigger when a button is tapped to the action didPressDoneButton which would in turn call completeReminder to toggle the isComplete boolean property of the reminder ---- ALSO ---- the target-action is an objective-c api which is why the #selector annotation is required since objective-c methods need to be represented by a specific selector type to be called
        button.id = reminder.id
        button.setImage(image, for: .normal)
        
        // return the custom view using the button view that was created above and placing it at the leading edge of the cell
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
    }
    
    // accessor method to get a reminder based on its id
    func reminder(for id: Reminder.ID) -> Reminder {
        let index = reminders.indexOfReminder(with: id)
        return reminders[index]
    }
    
    // updater method to update a reminder by passing in the new reminder as well as a reference to the old reminder's id
    func update(_ reminder: Reminder, with id: Reminder.ID) {
        let index = reminders.indexOfReminder(with: id)
        reminders[index] = reminder
    }
}
