//
//  AddNewTaskViewController.swift
//  TaskList
//
//  Created by jevania on 08/04/22.
//

import UIKit

class AddNewTaskViewController: UIViewController {

    @IBOutlet weak var TaskTitleTextField: UITextView!
    @IBOutlet weak var TaskDescriptionTextField: UITextView!
    @IBOutlet weak var TaskCategoryTextField: UITextView!
    
    let viewModel: TaskViewModel = TaskViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TaskTitleTextField.delegate = self
        TaskDescriptionTextField.delegate = self
        TaskCategoryTextField.delegate = self
        
        TaskTitleTextField.layer.borderWidth = 1
        TaskTitleTextField.layer.cornerRadius = 5
        TaskTitleTextField.layer.borderColor = UIColor.black.cgColor
        TaskTitleTextField.textColor = .lightGray
        TaskTitleTextField.text = "Write your task title here"
        
        TaskDescriptionTextField.layer.borderWidth = 1
        TaskDescriptionTextField.layer.cornerRadius = 5
        TaskDescriptionTextField.layer.borderColor = UIColor.black.cgColor
        TaskDescriptionTextField.isScrollEnabled = false
        TaskDescriptionTextField.textColor = .lightGray
        TaskDescriptionTextField.text = "Write your task description here"
        
        TaskCategoryTextField.layer.borderWidth = 1
        TaskCategoryTextField.layer.cornerRadius = 5
        TaskCategoryTextField.layer.borderColor = UIColor.black.cgColor
        TaskCategoryTextField.textColor = .lightGray
        TaskCategoryTextField.text = "Write your task category here"

    }
    
    @IBAction func AddTaskAction(_ sender: UIButton) {
        
        if TaskTitleTextField.text != "" &&
            TaskTitleTextField.text != "Write your task title here" &&
            TaskDescriptionTextField.text != "" &&
            TaskDescriptionTextField.text != "Write your task description here" &&
            TaskCategoryTextField.text != "" &&
            TaskCategoryTextField.text != "Write your task category here" {
            
                viewModel.addTask(taskTitle: TaskTitleTextField.text!, taskDescription: TaskDescriptionTextField.text!, taskCategory: TaskCategoryTextField.text!, isCompleted: false)
            
                self.navigationController?.popViewController(animated: true)
        
        }
        
    }
    
}

extension AddNewTaskViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing (_ textView: UITextView) {
        if TaskTitleTextField.textColor == .lightGray && TaskTitleTextField.isFirstResponder {
            TaskTitleTextField.text = nil
            TaskTitleTextField.textColor = .black
        }
        
        if TaskDescriptionTextField.isFirstResponder {
            TaskDescriptionTextField.text = nil
            TaskDescriptionTextField.textColor = .black
        }
        
        if TaskCategoryTextField.isFirstResponder {
            TaskCategoryTextField.text = nil
            TaskCategoryTextField.textColor = .black
        }
    }
    
    func textViewDidEndEditing (_ textView: UITextView) {
        if TaskTitleTextField.text.isEmpty || TaskTitleTextField.text == "" {
            TaskTitleTextField.textColor = .lightGray
            TaskTitleTextField.text = "Write your task title here"
        }
        
        if TaskDescriptionTextField.text.isEmpty || TaskDescriptionTextField.text == "" {
            TaskDescriptionTextField.textColor = .lightGray
            TaskDescriptionTextField.text = "Write your task description here"
        }
        
        if TaskCategoryTextField.text.isEmpty || TaskCategoryTextField.text == "" {
            TaskCategoryTextField.textColor = .lightGray
            TaskCategoryTextField.text = "Write your task category here"
        }
    }
}
