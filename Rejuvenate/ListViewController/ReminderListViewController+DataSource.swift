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
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String> // this is basically just assigning the diffable data source type to a new alias called DataSource. diffable data updates and animates the ui when data changes -> basically just live data
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, String> // the diffable data source manages data using snapshots -> snapshots represent the state of the data at a certain point in time (like context) -> will be applying the snap shot to display data in the ui
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
        // retrieve sample data
        let reminder = Reminder.sampleData[indexPath.item]
        
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
    
    // this configures the button on the side of each cell to toggle whether or not the reminder was completed
    private func doneButtonConfiguration(for reminder: Reminder) -> UICellAccessory.CustomViewConfiguration {
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        let button = UIButton()
        button.setImage(image, for: .normal)
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
    }
}
