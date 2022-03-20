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
        let reminder = Reminder.sampleData[indexPath.item] // retrieve sample data
        var contentConfiguration = cell.defaultContentConfiguration() // retrieve cell's default config
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
    }
}
