//
//  DesignableView.swift
//  AppTeatro
//
//  Created by HC5MAC10 on 09/08/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import UIKit

@IBDesignable class DesignableView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
}
