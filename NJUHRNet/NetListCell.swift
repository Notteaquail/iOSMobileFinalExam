//
//  NetListCell.swift
//  NJUHRNet
//
//  Created by apple on 2019/12/23.
//  Copyright © 2019 Notteaquail. All rights reserved.
//

import UIKit

class NetListCell: UITableViewCell {

    
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var clickCountIcon: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
