//
//  UIStackView + Extension.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 23.02.22.
//

import UIKit


extension UIStackView {
    
    convenience init(arrangedSubviews:[UIView],axis: NSLayoutConstraint.Axis,spacing:CGFloat) {
        self.init(arrangedSubviews:arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
    }
}
