//
//  SetupProfileViewController.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 24.02.22.
//

import UIKit

class SetupProfileViewController: UIViewController {
    let fillImageView = AddPhotoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupConstraints()
    }
}

// MARK: - Setup constraints
extension SetupProfileViewController {
    private func setupConstraints() {
        
        fillImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fillImageView)
        
        NSLayoutConstraint.activate([
            fillImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            fillImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

// MARK: - SwiftUI
import SwiftUI

struct SetupVCProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ContainerView().edgesIgnoringSafeArea(.all).previewInterfaceOrientation(.portrait)
        }
    }
    struct ContainerView: UIViewControllerRepresentable {
        let setupVC = SetupProfileViewController()
        
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return setupVC
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
