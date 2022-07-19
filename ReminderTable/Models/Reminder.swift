//
//  Reminder.swift
//  ReminderTable
//
//  Created by Vasanth Gentela on 15/07/22.
//
import Foundation
import RealmSwift

class Reminder{
  var title:String
  var dueDate:Date
  var notes:String?
  var isComplete:Bool = false
  var image:String
  init(title:String,dueDate:Date,notes:String?,isComplete:Bool){
    self.title = title
    self.dueDate = dueDate
    self.notes = notes
    self.isComplete = isComplete
  }
}
#if DEBUG
extension Reminder{
  static var sampleData = [
    Reminder(title: "Submit reimbursement report", dueDate: Date().addingTimeInterval(800.0), notes: "Don't forget about taxi receipts",image:"report"),
    Reminder(title: "Code review", dueDate: Date().addingTimeInterval(14000.0), notes: "Check tech specs in shared folder", isComplete: true,image:"code"),
    Reminder(title: "Pick up new contacts", dueDate: Date().addingTimeInterval(24000.0), notes: "Optometrist closes at 6:00PM",image:"contacts"),
    Reminder(title: "Add notes to retrospective", dueDate: Date().addingTimeInterval(3200.0), notes: "Collaborate with project manager", isComplete: true,image:"notes"),
    Reminder(title: "Interview new project manager candidate", dueDate: Date().addingTimeInterval(60000.0), notes: "Review portfolio",image:"interview"),
    Reminder(title: "Mock up onboarding experience", dueDate: Date().addingTimeInterval(72000.0), notes: "Think different",image:"onboard"),
    Reminder(title: "Review usage analytics", dueDate: Date().addingTimeInterval(83000.0), notes: "Discuss trends with management",image:"analytics"),
    Reminder(title: "Confirm group reservation", dueDate: Date().addingTimeInterval(92500.0), notes: "Ask about space heaters",image:"confirm"),
    Reminder(title: "Add beta testers to TestFlight", dueDate: Date().addingTimeInterval(101000.0),  notes: "V12.0 should be updated",image:"test")
  ]
}
#endif
