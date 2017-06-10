//
//  TeatroTableViewCell.swift
//  AppTeatro
//
//  Created by Thiago Sousa on 10/06/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

class TeatroTableViewCell: UITableViewCell {

    @IBOutlet weak var imgViewTeatro: UIImageView!
    @IBOutlet weak var labelTituloTeatro: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
