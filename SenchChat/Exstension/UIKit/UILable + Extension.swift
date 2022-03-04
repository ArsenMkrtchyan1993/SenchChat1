//
//  UILable + Extension.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 22.02.22.
//

import Foundation
import UIKit

extension UILabel {
    
    convenience init (title:String,font:UIFont? = .avenir20()){
        self.init()
        self.text = title
        self.font = font
    }
}
