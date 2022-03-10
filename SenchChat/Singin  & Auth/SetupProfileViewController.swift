//
//  SetupProfileViewController.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 24.02.22.
//

import UIKit
import FirebaseAuth

class SetupProfileViewController: UIViewController {
    let fillImageView = AddPhotoView()
    let setupLabel = UILabel(title: "Set up profile!", font: .avenir26())
    let fullNameLabel = UILabel(title: "Full Name")
    let aboutMeLabel = UILabel(title: "About me")
    let sexLabel = UILabel(title: "Sex")
    let fullNameTextField = OneLineTextField(font: .avenir20())
    let aboutMeTextField = OneLineTextField(font: .avenir20())
    let sexSegmentControl = UISegmentedControl(first: "Male", second: "Female")
    let goToChatsButton = UIButton(title: "Go to chats!", titleColor: .white, backgroundColor: .buttonDark(), isShadow: false)
    
    private var currentUser: User
        init(currentUser: User){
            self.currentUser = currentUser
            super.init(nibName: nil, bundle: nil)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupConstraints()
        goToChatsButton.addTarget(self, action: #selector(goToChatsButtonTappet), for: .touchUpInside)
    }
    
    @objc private func goToChatsButtonTappet() {
        FirestoreService.shared.saveProfileWith(id: currentUser.uid,
                                                email: currentUser.email!,
                                                userName: fullNameTextField.text,
                                                avatarImageString: "nil",
                                                description: aboutMeTextField.text,
                                                sex: sexSegmentControl.titleForSegment(at: sexSegmentControl.selectedSegmentIndex)) { result in
            switch result {
                
            case .success(let mUser):
                self.showAlert(title: "Good", message: "Bari jamanc")
                    print(mUser)
            case .failure(let error):
                self.showAlert(title: "Good", message:error.localizedDescription)
            }
        }
    }
    

}

// MARK: - Setup constraints
extension SetupProfileViewController {
    private func setupConstraints() {
        let fullNameStackView = UIStackView(arrangedSubviews: [fullNameLabel,fullNameTextField], axis: .vertical, spacing: 0)
        let aboutMeStackView = UIStackView(arrangedSubviews: [aboutMeLabel,aboutMeTextField], axis: .vertical, spacing: 0)
        let sexStackView = UIStackView(arrangedSubviews: [sexLabel,sexSegmentControl], axis: .vertical, spacing: 10)
        goToChatsButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let stackView = UIStackView(arrangedSubviews: [
                                        fullNameStackView,
                                        aboutMeStackView,
                                        sexStackView,
                                        goToChatsButton
                                        
        ], axis: .vertical, spacing: 40)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        fillImageView.translatesAutoresizingMaskIntoConstraints = false
        setupLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fillImageView)
        view.addSubview(setupLabel)
        view.addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            setupLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 138),
            setupLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            fillImageView.topAnchor.constraint(equalTo: setupLabel.bottomAnchor, constant: 40),
            fillImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: fillImageView.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
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
        let setupVC = SetupProfileViewController(currentUser: Auth.auth().currentUser!)
        
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return setupVC
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
