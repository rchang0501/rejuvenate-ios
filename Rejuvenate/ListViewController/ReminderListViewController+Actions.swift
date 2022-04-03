//
//  ReminderListViewController+Actions.swift
//  Rejuvenate
//
//  Created by Ryan Chang on 2022-03-20.
//

import UIKit

extension ReminderListViewController {
    // the @objc annotation makes this function available to objective-c --> is placed here because this function will be accessing an objective-c api
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else {return}
        completeReminder(with: id) // this function toggles the reminder's isComplete boolean property
    }
    
    @objc func didPressAddButton(_ sender: UIBarButtonItem) {
        let reminder = Reminder(title: "", dueDate: Date.now)
        let viewController = ReminderViewController(reminder: reminder) { [weak self] reminder in // use weak self to prevent the reminder view controller from capturing and storing a strong reference to the reminder list view controller
            self?.add(reminder) // call add function defined in the DataSource file
            self?.updateSnapshot() // update the snapshot so the list reloads with the updates
            self?.dismiss(animated: true) // dismiss the view controller to hide edit view
        }
        viewController.isAddingNewReminder = true // set the editing mode to adding
        viewController.setEditing(true, animated: false)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didCancelAdd(_:))) // create a left bar button that cancels the adding process
        viewController.navigationItem.title = NSLocalizedString("Add Skincare Reminder", comment: "Add Reminder view controller title")
        let navigationController = UINavigationController(rootViewController: viewController) // create a new navigation controller with the reminder view controller as the root
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    @objc func didCancelAdd(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @objc func didChangeListStyle(_ sender: UISegmentedControl) {
        listStyle = ReminderListStyle(rawValue: sender.selectedSegmentIndex) ?? .today
        updateSnapshot()
    }
}
