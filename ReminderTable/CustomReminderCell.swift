//
//  customReminderCell.swift
//  ReminderTable
//
//  Created by Vasanth Gentela on 16/07/22.
//

import UIKit

class CustomReminderCell: UITableViewCell {

  @IBOutlet var cellView: UIView!
  @IBOutlet var reminderImage: UIImageView!
  @IBOutlet var reminderStatusLabel: UIButton!
  @IBOutlet var reminderDue: UITextField!
  @IBOutlet var reminderLabel: UILabel!

  @IBAction func reminderStatus(_ sender: UIButton) {
    if let buttonTitle = sender.title(for: .normal) {
      if buttonTitle == "done"{
        reminderDue.text = ""
        sender.isEnabled = false
      }
      else{
        print("already done")
      }
    }
  }

}
