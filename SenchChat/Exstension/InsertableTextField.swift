//
//  InsertableTextField.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 06.03.22.
//

import UIKit



class InsertableTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        placeholder = "Write something here .. "
        font =  UIFont.systemFont(ofSize: 14)
        clearButtonMode  = .whileEditing
        borderStyle = .none
        layer.cornerRadius = 18
        layer.masksToBounds = true
        let image = UIImage(systemName: "smiley")!
        image.withTintColor(.white)
        let imageView = UIImageView(image: image)
        imageView.setupColor(color: .lightGray)
        leftView = imageView
        leftView?.frame =  CGRect(x: 0, y: 0, width: 19, height: 19)
        leftViewMode = .always
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Sent"), for: .normal)
        button.applyGradients(cornerRadius: 10)
        rightView = button
        rightView?.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
        rightViewMode = .always
        
    }
    
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += 12
        return rect
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x += -10
        return rect
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 40, dy: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    
}
// MARK: - SwiftUI


import SwiftUI

struct InsertableTextFieldVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let ProfileVC = ProfileViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<InsertableTextFieldVCProvider.ContainerView>) -> ProfileViewController {
            return ProfileVC
        }
        
        func updateUIViewController(_ uiViewController: InsertableTextFieldVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<InsertableTextFieldVCProvider.ContainerView>) {
            
        }
    }
}