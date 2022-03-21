//
//  ReminderViewController.swift
//  Rejuvenate
//
//  Created by Ryan Chang on 2022-03-20.
//

import UIKit

// this class lays out the list of reminder details and supplies the list with the reminder details data
class ReminderViewController: UICollectionViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Int, Row> // uses Int for section numbers and Row for list rows
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Row>
    
    var reminder: Reminder
    private var dataSource: DataSource!
    
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
    
    // this is basically just onCreate()
    // intervene in the view controller's lifecycle to register the cell with the collection view and create the data source after is loads 
    override func viewDidLoad() {
        super.viewDidLoad() // first call the super class implementation to do its own thing before your custom implementaitons
        
        // register the cell in the collection view using the registration handler defined below
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        
        //create a new data source that will dequeue cells that cannot be seen on screen (recycler view)
        dataSource = DataSource(collectionView: collectionView) {(collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Row) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        // apply a snapshot of the datasource to the collection view once it loads 
        updateSnapshot()
    }
    
    // function that sets up each cell in the list
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        // style the content
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle) // row.textStyle changes based on the case
        contentConfiguration.image = row.image
        
        // assign the content configuration style to collection's view cell
        cell.contentConfiguration = contentConfiguration
        cell.tintColor = .rejuvenatePrimaryTint
    }
    
    // function that will update the snapshot to the most recent instance so the datasource will be up to date for the ui
    private func updateSnapshot(){
        var snapshot = Snapshot()
        snapshot.appendSections([0]) // this is the Int part of the <Int, Row> --> the section that is the general container for the cells
        snapshot.appendItems([.viewTitle, .viewDate, .viewTime, .viewNotes], toSection: 0) // provide 4 instances of Row as view items to the snapshot
        dataSource.apply(snapshot) // push the snapshot to the data source
    }
    
    // access the coresponding reminder text based on the cases
    func text(for row: Row ) -> String? {
        switch row {
        case .viewDate: return reminder.dueDate.dayText
        case .viewNotes: return reminder.notes
        case .viewTime: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
        case .viewTitle: return reminder.title
        }
    }
}
