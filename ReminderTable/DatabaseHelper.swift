//
//  DatabaseHelper.swift
//  ReminderTable
//
//  Created by Vasanth Gentela on 19/07/22.
//

import Foundation
import RealmSwift

class DatabaseHelper {

  static let shared = DatabaseHelper()
  private var realm = try! Realm()

  private init (){
    
  }
  func getDatabaseURL() -> URL? {
    return Realm.Configuration.defaultConfiguration.fileURL
  }
  func isEmpty() -> Bool {
    return realm.objects(Reminder.self).isEmpty
  }
  func getStoredReminders() -> Results<Reminder>{
    return realm.objects(Reminder.self)
  }
  func saveReminder(reminder:Reminder){
    try! realm.write{
      realm.add(reminder)
    }
  }
  func deleteReminder(reminder:Reminder){
    try! realm.write{
      realm.delete(reminder)
    }
  }
}
