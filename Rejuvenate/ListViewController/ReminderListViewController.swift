//
//  ViewController.swift
//  Rejuvenate
//
//  Created by Ryan Chang on 2022-03-17.
//

import UIKit

// this is the view controller (the c in mvc)
// basically it's swift's version of the view model
class ReminderListViewController: UICollectionViewController {
    
    var dataSource: DataSource! // this implicity unwraps DataSource and ensures it will be assigned a value -> basically just an lateinit var
    var reminders: [Reminder] = Reminder.sampleData
    
    // this is basically just oncreate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout // this assigns the listLayout defined in the private func to the ui's collection view
        
        // cell registration specifies how to configure the content and appearance of the cell
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        
        // in the data source initilizer you pass a closure that configures and returns a cell for the collection view -> closrue is just a lambda
        // the closure accepts two inputs: an index path to the location of the cell and an itemIdentifier
        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Reminder.ID) in // in separates the parameters from the return type in the closure
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier) // the dequeueConfiguredReusableCell is the same as recycler view in android
        }
        
        updateSnapshot() //this applies the new snapshot to the datasource 
        
        collectionView.dataSource = dataSource // collectionView is from the super class UICollectionViewController and .dataSource was defined in this file
    }
    
    // function to show the detail view when a cell in the collection is tapped
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        // set up properties
        let id = reminders[indexPath.item].id // retrieve the id of the reminder at the specified index path --> indexPath.item is an int so it can be used as an array index to retrieve the correct element
        
        // call the showDetail function to display the detail view
        showDetail(for: id) // this function adds the detail view controller onto the navigation stack, enabling the detai view to be pushed onto the screen. a back button appears automatically as the leading element in the navigation bar
        
        return false // your return false to ensure that hte cell doesn't enter a selected mode when it is tapped, instead we just want to show the detail view
    }
    
    // this function will handle showing the detail view
    func showDetail(for id: Reminder.ID) {
        // set up properties
        let reminder = reminder(for: id) // get the remidner object based on the id 
        let viewController = ReminderViewController(reminder: reminder) { [weak self] reminder in // instatiate a new detail view
            self?.update(reminder, with: reminder.id) // updates the array of reminders in the data source with the edited reminder
            self?.updateSnapshot(reloading: [reminder.id]) // updates the snapshot and thus ui to refelct the changes made 
        }
        
        // push the detail view controller onto the navigation controller stack
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // this funciton defines how the list ui will appear
    // a compositional layout lets you contstruct views by combining different components e.g. sections, groups, and items
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped) // this creates a section in a list layout (the outer container view that surrounds the group of items)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration) // returns a new compositional layout
    }
}
