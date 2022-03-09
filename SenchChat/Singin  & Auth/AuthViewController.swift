//
//  ViewController.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 21.02.22.
//

import UIKit

class AuthViewController: UIViewController {
    
    let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Logo"), contentMode: .scaleAspectFit)
    
    let googleLabel = UILabel(title: "Get started with")
    let emailLabel = UILabel(title: "Or sign up with")
    let loginLabel = UILabel(title: "Already onboard?")
    
    let singUpVC = SingUpViewController()
    let loginVC = LoginViewController()
    let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white,  isShadow: true)
    let phoneButton = UIButton(title: "Phone", titleColor: .butonGreen, backgroundColor: .white, isShadow: true)
    let emailButton = UIButton(title: "Email", titleColor: .white, backgroundColor: .buttonDark(), isShadow: false)
    let loginButton = UIButton(title: "Login", titleColor: .buttonRed(), backgroundColor: .white, isShadow: true)
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        googleButton.customizeGoogleButton()
        phoneButton.customizePhoneButton()
        view.backgroundColor = .white
        setupConstraints()
       
        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
    }
    
    
    @objc private func emailButtonTapped() {
        present(singUpVC, animated: true, completion: nil)
         
    }
    @objc private func loginButtonTapped() {
        present(loginVC, animated: true, completion: nil)
    }
    
}

// MARK: - Setup constraints

extension AuthViewController {
    
    
    private func setupConstraints() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let googleButtonView = ButtonFormView(label: googleLabel, button: googleButton)
        let emailButtonView = ButtonFormView(label: UILabel(title: ""), button: emailButton)
        let loginButtonView = ButtonFormView(label: loginLabel, button: loginButton)
        let phoneButtonView = ButtonFormView(label: emailLabel, button: phoneButton)
        let stackView = UIStackView(arrangedSubviews: [googleButtonView,phoneButtonView, emailButtonView, loginButtonView])
        stackView.axis = .vertical
        stackView.spacing = 40
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

// MARK: - SwiftUI

import SwiftUI

struct AuthVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = AuthViewController()
        
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
    
}

