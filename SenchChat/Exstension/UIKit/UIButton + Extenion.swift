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
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
            self.layer.shadowRadius = 4
            self.layer.shadowOpacity = 1.0
           
        }
    }
    
    func customizeGoogleButton() {
        let googleImage = UIImageView(image: #imageLiteral(resourceName: "googleLogo"), contentMode: .scaleAspectFit)
        googleImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(googleImage)
        googleImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        googleImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    
    func customizePhoneButton() {
        let image = UIImage(systemName: "phone")
        image!.withTintColor(.butonGreen)
        let phoneImage = UIImageView(image: image, contentMode: .scaleAspectFit)
        phoneImage.setupColor(color: .butonGreen)
        
        phoneImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(phoneImage)
        phoneImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        phoneImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
   
}
