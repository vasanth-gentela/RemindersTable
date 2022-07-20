//
//  ViewController.swift
//  ReminderTable
//
//  Created by Vasanth Gentela on 15/07/22.
//

import UIKit
import SwiftUI

class ReminderViewController: UIViewController{

  var reminders:[Reminder] = []

  @IBOutlet var reminderTableView: UITableView!


  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Reminders"
    navigationController?.navigationBar.prefersLargeTitles = true
    reminderTableView.delegate = self
    reminderTableView.dataSource = self
    reminderTableView.prefetchDataSource = self
    let data = DatabaseHelper.shared.getStoredReminders().count
    print("Total reminders are: \(data)")
//    DatabaseHelper.shared.deleteAll()
    addDefaultReminders()
    reminderTableView.reloadData()

  }


  

  @IBAction func addReminderButton(_ sender: UIBarButtonItem) {
    let alert = UIAlertController(title: "Add reminder", message:"Please enter required details for Reminder", preferredStyle: .alert)
    alert.addTextField{title in
      title.placeholder = "Title of Reminder"
    }
    alert.addTextField{
      days in
      days.placeholder = "Days remained to complete"    }
    let ok = UIAlertAction(title: "Ok", style: .default){ _ in
      if let value = alert.textFields?.first?.text, let days = alert.textFields?[1].text{
        if !value.isEmpty, !days.isEmpty{
          guard let _ = Int(days) else {print("Days cannot be a string");return}
          let rem = Reminder(title: value,dueDate: Date().addingTimeInterval( TimeInterval(Int(days)! * 24 * 60 * 60)))
          self.reminders.append(rem)
          DatabaseHelper.shared.saveReminder(reminder: rem)
          self.reminderTableView.insertRows(at: [IndexPath(row: self.reminders.count - 1, section: 0)], with: .fade)
        }
        else{print("Reminder not added")}
      }
    }
    let cancel = UIAlertAction(title: "Cancel", style: .default)
    alert.addAction(ok)
    alert.addAction(cancel)
    present(alert, animated: true)
  }


  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return reminders.count
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let reminder = reminders[indexPath.item]

    tableView.deselectRow(at: indexPath, animated: true)
    print("""
you have selected  "\(reminder.title)" with status \(reminder.isComplete) reminder
""")
  }
}
