//
//  UIImageView + Extension.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 22.02.22.
//

import Foundation
import UIKit

extension UIImageView {
    convenience init (image: UIImage?, contentMode:UIView.ContentMode) {
        self.init()
        self.image = image
        self.contentMode = contentMode
    }
    
}
