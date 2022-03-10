//
//  SingUpViewController.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 23.02.22.
//

import UIKit

protocol AuthNavigatingDelegate: class {
    func toLoginVC()
    func toSingUpVC()
}

class SingUpViewController: UIViewController {
    
    let welcomeLabel = UILabel(title: "God to see you!", font: .avenir26())
    let emailLabel = UILabel(title: "Email")
    let passwordLabel = UILabel(title: "Password")
    let confirmPasswordLabel = UILabel(title: "Confirm password")
    let alreadyOnBoardLabel = UILabel(title: "Already onboard?")
    let singUpButton = UIButton(title: "Sign Up", titleColor: .white, backgroundColor: .buttonDark(), isShadow: false)
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.buttonRed(), for: .normal)
        button.titleLabel?.font = .avenir20()
        return button
    }()
    weak var delegate: AuthNavigatingDelegate?
    
    let emailTextField = OneLineTextField(font: .avenir20())
    let passwordTextField = OneLineTextField(font: .avenir20())
    let confirmPasswordTextFiled = OneLineTextField(font: .avenir20())
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       
        setupConstraints()
        
        singUpButton.addTarget(self, action: #selector(singUpButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    
    @objc private func singUpButtonTapped() {
        AuthService.shared.register(email: emailTextField.text,
                                    password: passwordTextField.text,
                                    confirmPass: confirmPasswordTextFiled.text) { result in
            switch result {
                
            case .success(let user ):
                self.showAlert(title: "Good", message: "You are in bord") {
                    self.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
                }
            case .failure(let error):
                self.showAlert(title: "error", message: error.localizedDescription)
            }
        }
    }
    
    @objc private func loginButtonTapped() {
        dismiss(animated: true) {
            self.delegate?.toLoginVC()
        }
        
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
        loginButton.contentHorizontalAlignment = .leading
        let loginStackView = UIStackView(arrangedSubviews: [alreadyOnBoardLabel,loginButton], axis: .horizontal, spacing:10)
       
        loginStackView.alignment = .firstBaseline
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
        Group {
            ContainerView().edgesIgnoringSafeArea(.all).previewInterfaceOrientation(.portrait)
        }
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

extension UIViewController {
    
    
    func showAlert(title:String, message:String,completion: @escaping () -> Void = {}){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title:"OK",style:.default) { (_)
            in completion()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
