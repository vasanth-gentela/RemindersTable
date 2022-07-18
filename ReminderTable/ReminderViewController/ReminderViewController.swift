//
//  ViewController.swift
//  ReminderTable
//
//  Created by Vasanth Gentela on 15/07/22.
//

import UIKit

class ReminderViewController: UIViewController{
  let reminders = Reminder.sampleData


  @IBOutlet var reminderTableView: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Reminders"
    navigationController?.navigationBar.prefersLargeTitles = true
    reminderTableView.delegate = self
    reminderTableView.dataSource = self
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
