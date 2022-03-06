//
//  ProfileViewController.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 06.03.22.
//

import UIKit


class ProfileViewController: UIViewController {
    let containerView = UIView()
    let imageView = UIImageView(image: #imageLiteral(resourceName: "human6"), contentMode: .scaleAspectFill)
    let nameLabel = UILabel(title: "Arsen mkrtchyan", font: .systemFont(ofSize: 20,weight: .light))
    let aboutMyLabel = UILabel(title: "Shat urax klines canotanalu im het", font: .systemFont(ofSize: 16, weight: .light))
    let myTextField = UITextField()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainWhite()
        setupConstraints()
    }
    
    
    
    
}

extension ProfileViewController {
    
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutMyLabel.translatesAutoresizingMaskIntoConstraints = false
        myTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        
        aboutMyLabel.numberOfLines = 0
        containerView.backgroundColor = .red
        //containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 30
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(aboutMyLabel)
        containerView.addSubview(myTextField)
        myTextField.borderStyle = .roundedRect
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        containerView.heightAnchor.constraint(equalToConstant: 206)
        ])
        
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 35),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -24)
        ])
        NSLayoutConstraint.activate([
            aboutMyLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 10),
            aboutMyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 24),
            aboutMyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -24)
        ])
        NSLayoutConstraint.activate([
            myTextField.topAnchor.constraint(equalTo: aboutMyLabel.bottomAnchor,constant: 10),
            myTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 24),
            myTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -24),
            myTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
}
// MARK: - SwiftUI


import SwiftUI

struct ProfileVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let ProfileVC = ProfileViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ProfileVCProvider.ContainerView>) -> ProfileViewController {
            return ProfileVC
        }
        
        func updateUIViewController(_ uiViewController: ProfileVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProfileVCProvider.ContainerView>) {
            
        }
    }
}
