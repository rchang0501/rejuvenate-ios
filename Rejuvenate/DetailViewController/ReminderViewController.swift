//
//  ReminderViewController.swift
//  Rejuvenate
//
//  Created by Ryan Chang on 2022-03-20.
//

import UIKit

// this class lays out the list of reminder details and supplies the list with the reminder details data
class ReminderViewController: UICollectionViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row> // uses Int (now Section) for section numbers and Row for list rows
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
    
    var reminder: Reminder {
        didSet { // observes when the value is changed
            onChange(reminder) // if it is changed, call onChange, passing in the reminder 
        }
    }
    var workingReminder: Reminder // stores edits until user chooses to confirm or cancel
    var onChange: (Reminder)->Void // will define behaviors to perform every time a reminder changes
    private var dataSource: DataSource!
    
    // object initializer (constructor)
    init(reminder: Reminder, onChange: @escaping (Reminder)->Void) {
        self.reminder = reminder
        self.workingReminder = reminder
        self.onChange = onChange
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped) // this configures the layout style of the ui collection list view
        listConfiguration.showsSeparators = false // remove the lines between each cell
        listConfiguration.headerMode = .firstItemInSection // set the header title for each row
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
        
        // set the nav bar title
        navigationItem.title = NSLocalizedString("Reminder", comment: "Reminder view controller title")
        // set the nav bar's edit button in the top right corner
        navigationItem.rightBarButtonItem = editButtonItem
        
        // apply a snapshot of the datasource to the collection view once it loads
        // REFACTORED --> this will only update the snapshot for the viewing mode, there is a different one for editing mode
        updateSnapshotForViewing()
    }
    
    // setEditing is a built in functio ntaht will be called when the edit button is tappen --> this will override the defaults for custom implementations
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            prepareForEditing()
        } else {
            prepareForViewing()
        }
    }
    
    // function that sets up each cell in the list
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        // get the section for the specified indexPath (element number)
        let section = section(for: indexPath)
        switch(section, row){ // use tuple to group the section and row into a single compound value
        case (_, .header(let title)):
            cell.contentConfiguration = headerConfiguration(for: cell, with: title)
        case (.view, _):
            // assign the content configuration style to collection's view cell
            cell.contentConfiguration = defaultConfiguration(for: cell, at: row)
        case(.title, .editText(let title)):
            cell.contentConfiguration = titleConfiguration(for: cell, with: title)
        case (.date, .editDate(let date)):
            cell.contentConfiguration = dateConfiguration(for: cell, with: date)
        case (.notes, .editText(let notes)):
            cell.contentConfiguration = notesConfiguration(for: cell, with: notes)
        default:
            fatalError("Unexpected combination of section and row.")
        }
        
        cell.tintColor = .rejuvenatePrimaryTint
    }
    
    // function to handle the cancel button in editing mode
    @objc func didCancelEdit() {
        workingReminder = reminder // reset the working value to the og value to prepare for a different editing session
        setEditing(false, animated: true) // remove the editing view
    }
    
    // function to set up the editing functionality
    private func prepareForViewing(){
        navigationItem.leftBarButtonItem = nil // remove the cancel button from the view when in viewing mode
        if workingReminder != reminder {
            reminder = workingReminder
        }
        updateSnapshotForViewing()
    }
    
    // function that will update the snapshot to the most recent instance so the datasource will be up to date for the ui
    // this one is for view mode (there is another one for editing mode)
    private func updateSnapshotForViewing(){
        var snapshot = Snapshot()
        snapshot.appendSections([.view]) // this is the Int part of the <Int, Row> --> the section that is the general container for the cells --> updated it's no longer Int but Section --> this is still the identifier for what section we're reading updates for
        snapshot.appendItems([.header(""), .viewTitle, .viewDate, .viewTime, .viewNotes], toSection: .view) // provide 4 instances of Row as view items to the snapshot --> we pass an empty header because we don't need one in view mode
        dataSource.apply(snapshot) // push the snapshot to the data source
    }
    
    // function to set up the editing functionality
    private func prepareForEditing(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didCancelEdit)) // setting up the cancel button in the editing mode
        updateSnapshotForEditing()
    }
    
    // update the snapshot when in editing mode
    private func updateSnapshotForEditing(){
        var snapshot = Snapshot() // reminder -- snapshot represents the current state of the data
        snapshot.appendSections([.title, .date, .notes]) // add these sections to be monitored by the snapshot
        snapshot.appendItems([.header(Section.title.name), .editText(reminder.title)], toSection: .title)
        snapshot.appendItems([.header(Section.date.name), .editDate(reminder.dueDate)], toSection: .date)
        snapshot.appendItems([.header(Section.notes.name), .editText(reminder.notes)], toSection: .notes)
        dataSource.apply(snapshot)
    }
    
    // retrieves the section that the row we pass into it belongs to
    private func section(for indexPath: IndexPath) -> Section {
        // when in view mode all the items are displayed in section 1
        // when in editing mode all the title, date, and notes are separated into sections 1, 2, 3 respectively
        let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section
        guard let section = Section(rawValue: sectionNumber) else {
            fatalError("Unable to find matching section")
        }
        return section
    }
}
