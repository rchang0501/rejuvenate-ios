//
//  ReminderViewController.swift
//  Rejuvenate
//
//  Created by Ryan Chang on 2022-03-20.
//

import UIKit

// this class lays out the list of reminder details and supplies the list with the reminder details data 
class ReminderViewController: UICollectionViewController {
    var reminder: Reminder
    
    // object initializer (constructor)
    init(reminder: Reminder) {
        self.reminder = reminder
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped) // this configures the layout style of the ui collection list view
        listConfiguration.showsSeparators = false // remove the lines between each cell
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration) // this sets the layout to the list configuration defined above
        super.init(collectionViewLayout: listLayout) // this calls the UICollectionViewController's initializer --> in swift a swfit subclass must call the super class's intiatilizer during intialization
    }
    
    // failable initializer
    // this is here because Interface Builder stores archives of the view controllers we create and a view controller needs a init(coder:) block to be created using such archives. Since we only create this class with code, we will never use this initializer so we make it a failable initializer that just throws an error telling the you to use the other initializer 
    required init?(coder: NSCoder) {
        fatalError("Only initialize ReminderViewController using init(reminder: )")
    }
}
