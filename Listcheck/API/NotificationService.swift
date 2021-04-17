//
//  NotificationService.swift
//  Listcheck
//
//  Created by Abraham Estrada on 4/5/21.
//

import UIKit

struct NotificationService {
    
    static func askForUserPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) { success, error in
            if let error = error {
                print("Error requesting notification permissions: \(error.localizedDescription)")
            }
        }
    }
    
    static func goToAppPermissions() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }
    
    static func addTaskNotification(_ task: Task) {
        let content = UNMutableNotificationContent()
        content.title = task.title
        content.sound = .default
        content.body = task.taskDescription
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: task.dateDue), repeats: false)
        
        let request = UNNotificationRequest(identifier: task.id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error in scheduling task: \(error.localizedDescription)")
            }
        }
    }
    
    static func removeTaskNotification(_ task: Task) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [task.id])
    }
    
    static func removeAllTaskNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    static func clearNotificationForTask(_ task: Task) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [task.id])
    }
}
