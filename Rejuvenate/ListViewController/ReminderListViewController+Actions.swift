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
}
