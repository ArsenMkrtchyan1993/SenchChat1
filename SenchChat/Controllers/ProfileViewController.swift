//
//  ProfileViewController.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 06.03.22.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {
    let containerView = UIView()
    let imageView = UIImageView(image: #imageLiteral(resourceName: "human6"), contentMode: .scaleAspectFill)
    let nameLabel = UILabel(title: "Anahit Grigoryan", font: .systemFont(ofSize: 20,weight: .light))
    let aboutMyLabel = UILabel(title: "Shat urax klines canotanalu im het", font: .systemFont(ofSize: 16, weight: .light))
    let myTextField = InsertableTextField()
    private let user:MUser
    
    init(user: MUser) {
        self.user = user
        self.nameLabel.text = user.userName
        self.aboutMyLabel.text = user.description
        self.imageView.sd_setImage(with: URL(string: user.avatarStringURL), completed: nil)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainWhite()
        setupConstraints()
        customizeElements()
        
    }
    
    private func customizeElements() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutMyLabel.translatesAutoresizingMaskIntoConstraints = false
        myTextField.translatesAutoresizingMaskIntoConstraints = false
        aboutMyLabel.numberOfLines = 0
        containerView.backgroundColor = .mainWhite()
        //containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 30
        
        if  let button = myTextField.rightView as? UIButton {
            button.addTarget(self, action:#selector(sendMessage), for: .touchUpInside)
        }
        
    }
    
    @objc private func sendMessage() {
        guard let message = myTextField.text, message != "" else { return }
        self.dismiss(animated: true) {
            print(message)
            FirestoreService.shared.createWaitingChat(message: message,
                                                      receiver: self.user) { result in
                switch result {
                    
                case .success():
                    UIApplication.getTopViewController()?.showAlert(title: "Good", message: "Your message for \(self.user.userName) send.")
                case .failure(let error):
                    UIApplication.getTopViewController()?.showAlert(title: "Error", message: error.localizedDescription)
                }
            }
            
        }
    }
}
    





extension ProfileViewController {
    
    private func setupConstraints() {
        
        view.addSubview(imageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(aboutMyLabel)
        containerView.addSubview(myTextField)
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
