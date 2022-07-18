//
//  ReminderViewController+DataSource.swift
//  ReminderTable
//
//  Created by Vasanth Gentela on 15/07/22.
//

import Foundation
import UIKit

extension ReminderViewController: UITableViewDelegate, UITableViewDataSource{

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = reminderTableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath) as? CustomReminderCell else {fatalError() }
    let reminder = reminders[indexPath.item]

    cell.reminderLabel.textAlignment = .left
    cell.reminderLabel.text = reminder.title
    let font = UIFont.systemFont(ofSize: 14, weight: .bold)
    cell.reminderLabel.font = font
    cell.reminderLabel.numberOfLines = 2

    cell.reminderDue.text = (reminder.isComplete) ? "": reminder.dueDate.dayAndTimeText
    cell.reminderDue.layer.zPosition = 1

    cell.reminderStatusLabel.setTitle("done", for: .normal)
    let status = (reminder.isComplete) ? "done":"undone"
    if status == "done" {
      cell.reminderDue.text = ""
      cell.reminderStatusLabel.isEnabled = false
    }
    cell.reminderImage.image = UIImage(named:reminder.image)
    cell.reminderImage.layer.cornerRadius = cell.reminderImage.frame.width/2
    cell.reminderImage.layer.cornerRadius = cell.reminderImage.frame.height/2
    cell.reminderImage.clipsToBounds = true

    cell.cellView.layer.cornerRadius = 20
    return cell
  }
}
