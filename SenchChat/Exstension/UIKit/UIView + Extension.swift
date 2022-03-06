//
//  UIView + Extension.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 06.03.22.
//

import UIKit


extension UIView {
    
    func applyGradients(cornerRadius:CGFloat) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientView = GradientView(from: .top, to: .bottomLeading, startColor: #colorLiteral(red: 0.7882352941, green: 0.631372549, blue: 0.9411764706, alpha: 1), endColor: #colorLiteral(red: 0.4784313725, green: 0.6980392157, blue: 0.9215686275, alpha: 1))
        
        if let gradientLayer = gradientView.layer.sublayers?.first as?  CAGradientLayer  {
            gradientLayer.frame = self.bounds
            gradientLayer.cornerRadius = cornerRadius
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
       
    }
    
    
    
}
