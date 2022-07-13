//
//  TaskViewModel.swift
//  TaskList
//
//  Created by jevania on 08/04/22.
//

import Foundation

class TaskViewModel {
    
    var items: [TaskModel] = [] {
        didSet {
            saveTask()
        }
    }
    
    init() {
        getItems()
    }
    
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: "TaskList"),
            let savedTasks = try? JSONDecoder().decode([TaskModel].self, from: data)
        else { return }
        
        self.items = savedTasks
    }
    
    func addTask(taskTitle: String, taskDescription: String, taskCategory: String, isCompleted: Bool) {
        let newTask = TaskModel(taskTitle: taskTitle, taskDescription: taskDescription, taskCategory: taskCategory, isCompleted: false)
        items.append(newTask)
    }
    
    func updateTask(item: TaskModel) {
        if let index = items.firstIndex(where: {$0.taskTitle == item.taskTitle}) {
            items[index] = item.updateCompletion()
        }
    }
    
    func saveTask() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: "TaskList")
        }
    }
}
