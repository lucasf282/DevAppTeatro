//
//  EventoTableViewCell.swift
//  AppTeatro
//
//  Created by MyMac on 5/2/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

class EventoTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelDataHora: UILabel!
    @IBOutlet weak var labelPreco: UILabel!
    @IBOutlet weak var labelLocal: UILabel!
    @IBOutlet weak var Btn_favorito: UIButton!
    @IBOutlet weak var ImgView_capa: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
