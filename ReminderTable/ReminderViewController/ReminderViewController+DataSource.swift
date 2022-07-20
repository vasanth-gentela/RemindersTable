//
//  ReminderViewController+DataSource.swift
//  ReminderTable
//
//  Created by Vasanth Gentela on 15/07/22.
//

import Foundation
import UIKit

extension ReminderViewController: UITableViewDelegate, UITableViewDataSource,UITableViewDataSourcePrefetching{

  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    print("prefetched rows")
  }
  func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
    print("cancelled prefetched rows")
  }


  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = reminderTableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath) as? CustomReminderCell else {fatalError() }

    let reminder = reminders[indexPath.row]

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

  func addDefaultReminders(){
    if DatabaseHelper.shared.isEmpty(){
      let alert = UIAlertController(title: "Hey..!", message: "Do you want to proceed with default Reminders?", preferredStyle: .alert)
      let ok = UIAlertAction(title: "Ok", style: .default,handler: {
        action in
        self.reminders = Reminder.sampleData
        for rem in self.reminders { DatabaseHelper.shared.saveReminder(reminder: rem) }
        for _ in Range(1...10000){
          let rem = Reminder(title: "new Reminder", dueDate: Date().addingTimeInterval(TimeInterval(Int.random(in: 1...1000))))
          self.reminders.append(rem)
          DatabaseHelper.shared.saveReminder(reminder: rem)
        }
        self.reminderTableView.reloadData()
      } )
      let cancel = UIAlertAction(title: "Cancel", style: .default)
      alert.addAction(cancel)
      alert.addAction(ok)
      present(alert, animated: true)
    }
    else {
      let storedReminders = DatabaseHelper.shared.getStoredReminders()
      reminders.append(contentsOf: Array(storedReminders))
    }
  }

  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let delete = UIContextualAction(style: .destructive, title: "Delete", handler:{ _,_,_ in
      DatabaseHelper.shared.deleteReminder(reminder: self.reminders[indexPath.row])
      self.reminders.remove(at: indexPath.row)
      self.reminderTableView.deleteRows(at: [indexPath], with: .fade)
    })
    let configuration = UISwipeActionsConfiguration(actions: [delete])
    return configuration
  }
}


