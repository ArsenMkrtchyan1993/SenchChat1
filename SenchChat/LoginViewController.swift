//
//  LoginViewController.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 23.02.22.
//

import UIKit

class LoginViewController: UIViewController {
    let welcomeLabel = UILabel(title: "Welcome Back!", font: .avenir26())
    let loginWithLabel = UILabel(title: "Login with")
    let orLabel = UILabel(title: "or")
    let emailLabel = UILabel(title: "Email")
    let passwordLabel = UILabel(title: "Password")
    let needAnAccountLabel = UILabel(title: "Need an account?")
    
    let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white,  isShadow: true)
    let emailTextField = OneLineTextField(font: .avenir20())
    let passwordTextField = OneLineTextField(font: .avenir20())
    
    let loginButton = UIButton(title: "Login", titleColor: .white, backgroundColor: .buttonDark(), isShadow: false)
    let singUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sing up", for: .normal)
        button.setTitleColor(.buttonRed(), for: .normal)
        button.titleLabel?.font = .avenir20()
        return button
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        googleButton.customizeGoogleButton()
    }
}


// MARK: - Setup constraints

extension LoginViewController {
    private func setupConstraints() {
        // by my secure text
    
        passwordTextField.textContentType = .password
        passwordTextField.isSecureTextEntry = true
        //
        let googleButton = ButtonFormView(label: loginWithLabel, button: googleButton)
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel,emailTextField],axis: .vertical,spacing: 0)
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel,passwordTextField],axis: .vertical,spacing: 0)
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let stackView = UIStackView(arrangedSubviews: [
                                        googleButton,
                                        orLabel,
                                        emailStackView,
                                        passwordStackView,
                                        loginButton
        ], axis: .vertical, spacing: 40)
        singUpButton.contentHorizontalAlignment = .leading

        let bottomStackView = UIStackView(arrangedSubviews: [needAnAccountLabel, singUpButton], axis: .horizontal, spacing: 10)
        bottomStackView.alignment = .firstBaseline
       
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(welcomeLabel)
        view.addSubview(stackView)
        view.addSubview(bottomStackView)
        
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 103),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }

}






// MARK: - SwiftUI
import SwiftUI

struct LoginVCProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ContainerView().edgesIgnoringSafeArea(.all).previewInterfaceOrientation(.portrait)
        }
    }
    struct ContainerView: UIViewControllerRepresentable {
        let loginVC = LoginViewController()
        
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return loginVC
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
