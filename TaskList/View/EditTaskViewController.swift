//
//  EditTaskViewController.swift
//  TaskList
//
//  Created by jevania on 08/04/22.
//

import UIKit

class EditTaskViewController: UIViewController{
    
    @IBOutlet weak var TaskTitleEditField: UITextView!
    @IBOutlet weak var TaskDescriptionEditField: UITextView!
    @IBOutlet weak var TaskCategoryEditField: UITextView!
    
    var taskTitle: String = ""
    var taskDescription: String = ""
    var taskCategory: String = ""
    
    let viewModel: TaskViewModel = TaskViewModel()
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        index = viewModel.items.firstIndex(where: {$0.taskTitle == taskTitle})!
        
        TaskTitleEditField.text = taskTitle
        TaskTitleEditField.layer.borderWidth = 1
        TaskTitleEditField.layer.cornerRadius = 5
        TaskTitleEditField.layer.borderColor = UIColor.black.cgColor
        
        TaskDescriptionEditField.text = taskDescription
        TaskDescriptionEditField.layer.borderWidth = 1
        TaskDescriptionEditField.layer.cornerRadius = 5
        TaskDescriptionEditField.layer.borderColor = UIColor.black.cgColor
        
        TaskCategoryEditField.text = taskCategory
        TaskCategoryEditField.layer.borderWidth = 1
        TaskCategoryEditField.layer.cornerRadius = 5
        TaskCategoryEditField.layer.borderColor = UIColor.black.cgColor
    }

    @IBAction func DoneButtonTapped(_ sender: UIButton) {
        viewModel.items[index].taskTitle = TaskTitleEditField.text
        viewModel.items[index].taskDescription = TaskDescriptionEditField.text
        viewModel.items[index].taskCategory = TaskCategoryEditField.text
        
        self.navigationController?.popViewController(animated: true)
    }
}
