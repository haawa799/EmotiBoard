//
//  TableViewCell.swift
//  Emojicons
//
//  Created by Andrew K. on 10/6/14.
//  Copyright (c) 2014 Andrew K. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

  @IBOutlet weak var numberLabel: UILabel!
  @IBOutlet weak var cellTitleLabel: UILabel!
  @IBOutlet weak var rightImage: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
      
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
