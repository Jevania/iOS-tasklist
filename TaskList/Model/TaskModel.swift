//
//  TaskModel.swift
//  TaskList
//
//  Created by jevania on 08/04/22.
//

import Foundation

struct TaskModel: Codable {
    var taskTitle: String = ""
    var taskDescription: String = ""
    var taskCategory: String = ""
    var isCompleted: Bool
    
    init(taskTitle: String, taskDescription: String, taskCategory: String, isCompleted: Bool) {
        self.taskTitle = taskTitle
        self.taskDescription = taskDescription
        self.taskCategory = taskCategory
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> TaskModel {
        return TaskModel(taskTitle: taskTitle, taskDescription: taskDescription, taskCategory: taskCategory, isCompleted: !isCompleted)
    }
}
