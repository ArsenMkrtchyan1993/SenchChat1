//
//  UIButton + Extenion.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 22.02.22.
//

import Foundation
import UIKit

extension UIButton {
    
    convenience init(title: String,
                     titleColor:UIColor,
                     backgroundColor:UIColor,
                     font: UIFont? = UIFont.avenir20(),
                     isShadow:Bool,
                     cornerRadius:CGFloat = 4)
    {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = font
        self.layer.cornerRadius = cornerRadius
        
        if isShadow == true {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 4
            self.layer.opacity = 0.2
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
        }
    }
    
   
}
