//
//  SidebarMenuTableViewCell.swift
//  AppTeatro
//
//  Created by MyMac on 5/5/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

class SidebarMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ImgView_icone: UIImageView!
    @IBOutlet weak var label_opcao: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
