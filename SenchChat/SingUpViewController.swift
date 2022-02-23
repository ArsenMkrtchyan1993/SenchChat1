//
//  SingUpViewController.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 23.02.22.
//

import UIKit

class SingUpViewController: UIViewController {
    
    let welcomeLabel = UILabel(title: "God to see you!", font: .avenir26())
    let emailLabel = UILabel(title: "Email")
    let passwordLabel = UILabel(title: "Password")
    let confirmPasswordLabel = UILabel(title: "Confirm password")
    let alreadyOnBoardLabel = UILabel(title: "Already onboard?")
    let singUpButton = UIButton(title: "Sign Up", titleColor: .white, backgroundColor: .buttonDark(), isShadow: false)
    let loginButton = UIButton()
    let emailTextField = OneLineTextField()
    let passwordTextField = OneLineTextField()
    let confirmPasswordTextFiled = OneLineTextField()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.buttonRed(), for: .normal)
        loginButton.titleLabel?.font = .avenir20()
        setupConstraints()
        
        
    }
}



// MARK: - Setup constraints

extension SingUpViewController {
    private func setupConstraints() {
        // by my secure text
    
        passwordTextField.textContentType = .password
        passwordTextField.isSecureTextEntry = true
        //
        
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel,emailTextField],axis: .vertical,spacing: 0)
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel,passwordTextField],axis: .vertical,spacing: 0)
        let confirmPasswordStackView = UIStackView(arrangedSubviews: [confirmPasswordLabel,confirmPasswordTextFiled],axis: .vertical,spacing: 0)
        singUpButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let stackView = UIStackView(arrangedSubviews: [
                                                        emailStackView,
                                                        passwordStackView,
                                                        confirmPasswordStackView,
                                                        singUpButton],
                                                        axis: .vertical, spacing: 40)
        let loginStackView = UIStackView(arrangedSubviews: [alreadyOnBoardLabel,loginButton], axis: .horizontal, spacing: -1)
        loginStackView.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabel)
        view.addSubview(stackView)
        view.addSubview(loginStackView)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 160),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            loginStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 60),
            loginStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            loginStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}


// MARK: - SwiftUI

import SwiftUI

struct SingUpVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    struct ContainerView: UIViewControllerRepresentable {
        let singUpVC = SingUpViewController()
        
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return singUpVC
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
    
}

