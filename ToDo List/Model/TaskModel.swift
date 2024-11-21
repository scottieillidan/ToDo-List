//
//  TaskModel.swift
//  ToDo List
//
//  Created by Adam Miziev on 21/11/24.
//

import Foundation

struct TaskModel: Identifiable {
    var id = UUID()
    var title: String
    var taskDescription: String?
    var creationDate: Date
    var status: Bool
}
