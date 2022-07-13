//
//  TaskTableViewCell.swift
//  TaskList
//
//  Created by jevania on 08/04/22.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var TaskTitleLabel: UILabel!
    @IBOutlet weak var TaskDescriptionLabel: UILabel!
    @IBOutlet weak var TaskCategoryLabel: UILabel!
    @IBOutlet weak var TaskDoneButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
