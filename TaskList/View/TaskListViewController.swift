//
//  TaskListViewController.swift
//  TaskList
//
//  Created by jevania on 08/04/22.
//

import UIKit

class TaskListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var text1Label: UILabel!
    @IBOutlet weak var text2Label: UILabel!
    
    var selectedTitle: String = ""
    var selectedDescription: String = ""
    var selectedCategory: String = ""
    
    let viewModel: TaskViewModel = TaskViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            
            self.viewModel.getItems()
            self.tableView.reloadData()
            
            if self.viewModel.items.isEmpty{
                self.text1Label.isHidden = false
                self.text2Label.isHidden = false
            }else{
                self.text1Label.isHidden = true
                self.text2Label.isHidden = true
            }
        }
    }
    
    @objc func didTapDoneButton(_ sender: UIButton) {
        self.viewModel.updateTask(item: viewModel.items[sender.tag])
        print("did tap")
        self.tableView.reloadData()
    }
    
}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskTableViewCell
        
        cell.selectionStyle = .none
        
        cell.TaskTitleLabel.text = viewModel.items[indexPath.row].taskTitle
        cell.TaskDescriptionLabel.text = viewModel.items[indexPath.row].taskDescription
        cell.TaskCategoryLabel.text = viewModel.items[indexPath.row].taskCategory
        
        cell.layer.cornerRadius = 25
        cell.backgroundColor = UIColor.colorFromHex("#B4EBE9").withAlphaComponent(0.75)
        
        cell.TaskCategoryLabel.layer.cornerRadius = 5
        cell.TaskCategoryLabel.layer.backgroundColor = UIColor.colorFromHex("#FFB067").cgColor
        
//        cell.TaskDoneButton.tag = indexPath.row
//        cell.TaskDoneButton.addTarget(self, action: #selector(didTapDoneButton), for: UIControl.Event.touchUpInside)
//        
//        if viewModel.items[indexPath.row].isCompleted == true{
//            cell.TaskDoneButton.setImage(UIImage(systemName: "checkmark.circle"), for: UIControl.State.normal)
//            cell.backgroundColor = .systemGray5
//            cell.TaskCategoryLabel.layer.backgroundColor = UIColor.systemGray4.cgColor
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
            -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                self.viewModel.items.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.right)
                self.tableView.reloadData()
                completionHandler(true)
            }
            deleteAction.image = UIImage(systemName: "trash.fill")
            deleteAction.backgroundColor = .systemRed
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let pinAction = UIContextualAction(style: .normal, title: nil) { (_, _, completionHandler) in
            self.viewModel.items.move(from: indexPath.row, to: 0)
            self.tableView.reloadData()
            completionHandler(true)
        }
        pinAction.image = UIImage(systemName: "pin.fill")
        
        pinAction.backgroundColor = .systemOrange
        let configuration = UISwipeActionsConfiguration(actions: [pinAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedTitle = viewModel.items[indexPath.row].taskTitle
        selectedDescription = viewModel.items[indexPath.row].taskDescription
        selectedCategory = viewModel.items[indexPath.row].taskCategory

        print("selected title ->", selectedTitle)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "editTaskVC") as! EditTaskViewController
        vc.taskTitle = selectedTitle
        vc.taskCategory = selectedCategory
        vc.taskDescription = selectedDescription

        print("taskDescription = ", vc.taskDescription)

        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension Array
{
    mutating func move(from sourceIndex: Int, to destinationIndex: Int)
    {
        guard
            sourceIndex != destinationIndex
            && Swift.min(sourceIndex, destinationIndex) >= 0
            && Swift.max(sourceIndex, destinationIndex) < count
        else {
            return
        }

        let direction = sourceIndex < destinationIndex ? 1 : -1
        var sourceIndex = sourceIndex

        repeat {
            let nextSourceIndex = sourceIndex + direction
            swapAt(sourceIndex, nextSourceIndex)
            sourceIndex = nextSourceIndex
        }
        while sourceIndex != destinationIndex
    }
}
