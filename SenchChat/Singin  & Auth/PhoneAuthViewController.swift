//
//  PhoneAuthViewController.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 14.03.22.
//

import UIKit

class PhoneAuthViewController: UIViewController {
    
    let welcomeLabel = UILabel(title: "Please enter you phone number!", font: .avenir26())
    let phoneNumberLabel = UILabel(title: "Phone number white region code")
    let smsCodeLabel = UILabel(title: "Enter code")
    let singIpButton = UIButton(title: "Sign In", titleColor: .white, backgroundColor: .buttonDark(), isShadow: false)
    let phoneNumberTextField = OneLineTextField(font: .avenir20())
    let smsCodeTextField = OneLineTextField(font: .avenir20())
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        phoneNumberTextField.delegate = self
        self.dismissKeyboard()
        singIpButton.addTarget(self, action: #selector(singInButtonTapped), for: .touchUpInside)
        
    }
  
    
    @objc private func singInButtonTapped() {
        guard let verifyCode = smsCodeTextField.text, !verifyCode.isEmpty else {
            self.showAlert(title: "Error", message: "Please enter the verify code ")
            return
        }
        AuthService.shared.verifyCode(smsCode: verifyCode) { result in
            switch result {
                
            case .success(let user):
                self.showAlert(title: "Good", message: "You are in bord") {
                    FirestoreService.shared.getUserData(user: user) { result in
                        switch result {
                            
                        case .success(let mUser):
                            let mainTapBar = MainTabBarController(currentUser: mUser)
                            mainTapBar.modalPresentationStyle = .fullScreen
                            self.present(mainTapBar, animated: true, completion: nil)
                        case .failure(_):
                            self.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
                        }
                    }
                    
                }
            case .failure(let error):
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
            }
        }
}
// MARK: - UITextFieldDelegate

extension PhoneAuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textFiled: UITextField) -> Bool {
        textFiled.resignFirstResponder()
        if let number = textFiled.text, !number.isEmpty {
            AuthService.shared.phoneRegister(phoneNumber: number) { success in
                guard success else {
                    self.showAlert(title: "Error", message: "Incorrect number of phone")
                    return
                }
                self.showAlert(title: "Good", message: "Weight a sms code")
            }
        }
        return true
    }
}

// MARK: - Setup constraints

extension PhoneAuthViewController {
    
    private func setupConstraints() {
        
        phoneNumberTextField.textContentType = .telephoneNumber
        //smsCodeTextField.keyboardType = .numberPad
        
        phoneNumberTextField.text = "+"
        phoneNumberTextField.returnKeyType = .continue
        let emailStackView = UIStackView(arrangedSubviews: [phoneNumberLabel,phoneNumberTextField],axis: .vertical,spacing: 0)
        let passwordStackView = UIStackView(arrangedSubviews: [smsCodeLabel,smsCodeTextField],axis: .vertical,spacing: 0)
        singIpButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let stackView = UIStackView(arrangedSubviews: [
                                                        emailStackView,
                                                        passwordStackView,
                                                        singIpButton],
                                                        axis: .vertical, spacing: 40)
   
       

        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabel)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 160),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
    }
}


// MARK: - SwiftUI

import SwiftUI

struct PhoneAuthVCProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ContainerView().edgesIgnoringSafeArea(.all).previewInterfaceOrientation(.portrait)
        }
    }
    struct ContainerView: UIViewControllerRepresentable {
        let singUpVC = PhoneAuthViewController()
        
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return singUpVC
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
    
}

