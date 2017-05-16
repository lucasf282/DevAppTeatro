//
//  GeneroCollectionViewCell.swift
//  AppTeatro
//
//  Created by MyMac on 5/10/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

class GeneroCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label_genero: UILabel!
    @IBOutlet weak var btn_genero: UIButton!
    
    var btnIsSelected : Bool = false
    
    @IBAction func setectGenero(_ sender: Any) {
        if btnIsSelected{
            btn_genero.isSelected = false
            btnIsSelected = false
        }else{
            btn_genero.isSelected = true
            btnIsSelected = true
        }
    }
}
