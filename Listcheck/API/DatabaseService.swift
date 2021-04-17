//
//  DatabaseService.swift
//  Listcheck
//
//  Created by Abraham Estrada on 3/31/21.
//

import RealmSwift

let realm = try! Realm()

struct DatabaseService {
    
    static func toggleIsCompleted(_ task: Task) {
        do {
            try realm.write {
                task.isCompleted.toggle()
                if task.isCompleted {
                    task.dateCompleted = Date()
                } else {
                    task.dateCompleted = nil
                }
            }
            if task.isCompleted {
                NotificationService.removeTaskNotification(task)
                NotificationService.clearNotificationForTask(task)
            } else {
                NotificationService.addTaskNotification(task)
            }
        } catch {
            print("Error saving event, \(error)")
        }
    }
    
    static func editTask(_ task: Task) {
        do {
            NotificationService.removeTaskNotification(task)
            try realm.write {
                realm.add(task, update: .modified)
            }
            NotificationService.addTaskNotification(task)
        } catch {
            print("Error saving event, \(error)")
        }
    }
    
    static func addTask(_ task: Task) {
        do {
            try realm.write {
                realm.add(task)
            }
            NotificationService.addTaskNotification(task)
        } catch {
            print("Error saving event, \(error)")
        }
    }
    
    static func deleteTask(_ task: Task) {
        do {
            NotificationService.removeTaskNotification(task)
            try realm.write {
                realm.delete(task)
            }
        } catch {
            print("Error saving event, \(error)")
        }
        
    }
    
    static func deleteAllTasks() {
        do {
            try realm.write {
                realm.deleteAll()
            }
            NotificationService.removeAllTaskNotifications()
        } catch {
            print("Error saving event, \(error)")
        }
    }
}
