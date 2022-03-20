//
//  SetupProfileViewController.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 24.02.22.
//

import UIKit
import FirebaseAuth
import SDWebImage

class SetupProfileViewController: UIViewController {
    let fillImageView = AddPhotoView()
    let setupLabel = UILabel(title: "Set up profile!", font: .avenir26())
    let fullNameLabel = UILabel(title: "Full Name")
    let aboutMeLabel = UILabel(title: "About me")
    let sexLabel = UILabel(title: "Sex")
    let phoneNumberLabel = UILabel(title: "Phone Number")
    let fullNameTextField = OneLineTextField(font: .avenir20())
    let aboutMeTextField = OneLineTextField(font: .avenir20())
    let phoneNumberFiled = OneLineTextField(font: .avenir20())
    let sexSegmentControl = UISegmentedControl(first: "Male", second: "Female")
    let goToChatsButton = UIButton(title: "Go to chats!", titleColor: .white, backgroundColor: .buttonDark(), isShadow: false)
    
    private var currentUser: User
    
        init(currentUser: User){
            self.currentUser = currentUser
            super.init(nibName: nil, bundle: nil)
            if let username = currentUser.displayName {
                fullNameTextField.text = username
            }
           
            if let photoUrl = currentUser.photoURL {
                fillImageView.circleImageView.sd_setImage(with: photoUrl, completed: nil)
            }
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboard()
        view.backgroundColor = .white
        setupConstraints()
        if let userPhone = currentUser.phoneNumber{
            phoneNumberFiled.text = userPhone
            phoneNumberFiled.isEnabled = false
        }
        goToChatsButton.addTarget(self, action: #selector(goToChatsButtonTappet), for: .touchUpInside)
        fillImageView.plusButton.addTarget(self, action: #selector(plusButtonTappet), for: .touchUpInside)
       
    }
    @objc private func plusButtonTappet() {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                    self.openCamera()
                }))

                alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                    self.openGallery()
                }))

                alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

                self.present(alert, animated: true, completion: nil)
    }
    @objc private func goToChatsButtonTappet() {
       
        FirestoreService.shared.saveProfileWith(id: currentUser.uid,
                                                phoneNumber:phoneNumberFiled.text!,
                                                email: currentUser.email ?? "",
                                                userName: fullNameTextField.text,
                                                avatarImage:fillImageView.circleImageView.image,
                                                description: aboutMeTextField.text,
                                                sex: sexSegmentControl.titleForSegment(at: sexSegmentControl.selectedSegmentIndex)) { result in
            switch result {
                
            case .success(let mUser):
                let mainTapBar = MainTabBarController(currentUser: mUser)
                mainTapBar.modalPresentationStyle = .fullScreen
                self.showAlert(title: "Good", message: "Bari jamanc",completion: {
                    self.present(mainTapBar, animated: true, completion: nil)
                })
                    print(mUser)
            case .failure(let error):
                self.showAlert(title: "Good", message:error.localizedDescription)
            }
        }
    }
    

}

// MARK: - Photo source type


extension SetupProfileViewController {
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    private func openGallery() {
       if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
           let imagePicker = UIImagePickerController()
           imagePicker.delegate = self
           imagePicker.allowsEditing = true
           imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
           self.present(imagePicker, animated: true, completion: nil)
       }
       else
       {
           let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           self.present(alert, animated: true, completion: nil)
       }
   }
}


// MARK: - Setup constraints
extension SetupProfileViewController {
    private func setupConstraints() {
        phoneNumberFiled.text  = "+"
        phoneNumberFiled.keyboardType = .numberPad
        
        let fullNameStackView = UIStackView(arrangedSubviews: [fullNameLabel,fullNameTextField], axis: .vertical, spacing: 0)
        let phoneNumberStackView = UIStackView(arrangedSubviews: [phoneNumberLabel,phoneNumberFiled], axis: .vertical, spacing: 0)
        let aboutMeStackView = UIStackView(arrangedSubviews: [aboutMeLabel,aboutMeTextField], axis: .vertical, spacing: 0)
        let sexStackView = UIStackView(arrangedSubviews: [sexLabel,sexSegmentControl], axis: .vertical, spacing: 10)
        goToChatsButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let stackView = UIStackView(arrangedSubviews: [
                                        fullNameStackView,
                                        phoneNumberStackView,
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
// MARK: - UIImagePickerController Delegate
extension SetupProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        fillImageView.circleImageView.image = image
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
