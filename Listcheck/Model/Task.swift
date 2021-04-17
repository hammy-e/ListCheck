//
//  Task.swift
//  Listcheck
//
//  Created by Abraham Estrada on 3/31/21.
//

import RealmSwift

class Task: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var taskDescription: String = ""
    @objc dynamic var dateDue: Date = Date()
    @objc dynamic var isCompleted: Bool = false
    @objc dynamic var dateCompleted: Date?
    @objc dynamic var id = UUID().uuidString
}
