//
//  ExtensionString.swift
//  AppTeatro
//
//  Created by MyMac on 8/11/17.
//  Copyright © 2017 MyMac. All rights reserved.
//

import Foundation

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox.height
    }
}
