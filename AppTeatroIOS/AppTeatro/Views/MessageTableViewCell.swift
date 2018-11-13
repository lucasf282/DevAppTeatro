//
//  MessageTableViewCell.swift
//  AppTeatro
//
//  Created by Lucas Farias on 13/11/18.
//  Copyright © 2018 MyMac. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_usuario: UILabel!
    @IBOutlet weak var lbl_data: UILabel!
    @IBOutlet weak var textView_menssagem: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
