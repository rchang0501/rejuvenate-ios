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
        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in // in separates the parameters from the return type in the closure
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier) // the dequeueConfiguredReusableCell is the same as recycler view in android
        }
        
        var snapShot = SnapShot() // new empty snapshot variable
        snapShot.appendSections([0]) // add the section to it
        snapShot.appendItems(Reminder.sampleData.map{$0.title}) // map returns a new array containing the titles ($0 means the first instance in the sampleData array)
        dataSource.apply(snapShot) // applying the snapshot reflects the changes in the ui
        
        collectionView.dataSource = dataSource // collectionView is from the super class UICollectionViewController and .dataSource was defined in this file
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
