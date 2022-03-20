//
//  ChatRequestViewController.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 08.03.22.
//

import UIKit


class ChatRequestViewController: UIViewController {
    let containerView = UIView()
    let imageView = UIImageView(image: #imageLiteral(resourceName: "human6"), contentMode: .scaleAspectFill)
    let nameLabel = UILabel(title: "Anahit Grigoryan", font: .systemFont(ofSize: 20,weight: .light))
    let aboutMyLabel = UILabel(title: "Have you the opportunity to start a new chat", font: .systemFont(ofSize: 16, weight: .light))
    let acceptButton = UIButton(title: "ACCEPT", titleColor: .white, backgroundColor: .black, font: .laoSangamMN20(), isShadow: false, cornerRadius: 10)
    let danyButton = UIButton(title: "Dany", titleColor:#colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1), backgroundColor: .mainWhite(), font: .laoSangamMN20(), isShadow: false, cornerRadius: 10)
    private var chat: MChat
    weak var delegate: WaitingChatNavigation?
    
    
    
    
    init(chat: MChat) {
        self.chat = chat
        self.imageView.sd_setImage(with: URL(string: chat.friendImageString), completed: nil)
        self.nameLabel.text = "\(chat.friendUserName) write you \(chat.lastMessage)"
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        customizeElements()
        setupConstraints()
        self.dismissKeyboard()
        danyButton.addTarget(self, action: #selector(danyButtonTapped), for: .touchUpInside)
        acceptButton.addTarget(self, action: #selector(acceptButtonTapped), for: .touchUpInside)
    }
    
    
    @objc private func danyButtonTapped() {
        self.dismiss(animated: true) {
            self.delegate?.removeWaitingChat(chat: self.chat)
        }
    }
    
    @objc private func acceptButtonTapped() {
        self.dismiss(animated: true) {
            self.delegate?.chatToActive(chat: self.chat)
        }
    }
    
    
    private func customizeElements() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutMyLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutMyLabel.numberOfLines = 0
        containerView.backgroundColor = .mainWhite()
        //containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 30
        danyButton.layer.borderWidth = 1.2
        danyButton.layer.borderColor = #colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1)
        
             
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.acceptButton.applyGradients(cornerRadius: 10)
    }
}


extension ChatRequestViewController {
    
    private func setupConstraints() {
        
        view.addSubview(imageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(aboutMyLabel)
        let buttonStackView = UIStackView(arrangedSubviews: [acceptButton,danyButton], axis: .horizontal, spacing: 7)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.distribution = .fillEqually
        containerView.addSubview(buttonStackView)
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
            buttonStackView.topAnchor.constraint(equalTo: aboutMyLabel.bottomAnchor,constant: 24),
            buttonStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 24),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -24),
            buttonStackView.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    
    
}
// MARK: - SwiftUI


//import SwiftUI
//
//struct ChatRequestProvider: PreviewProvider {
//    static var previews: some View {
//        ContainerView().edgesIgnoringSafeArea(.all)
//    }
//
//    struct ContainerView: UIViewControllerRepresentable {
//
//        let ChatRequestVC = ChatRequestViewController()
//
//        func makeUIViewController(context: UIViewControllerRepresentableContext<ChatRequestProvider.ContainerView>) -> ChatRequestViewController {
//            return ChatRequestVC
//        }
//
//        func updateUIViewController(_ uiViewController: ChatRequestProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ChatRequestProvider.ContainerView>) {
//
//        }
//    }
//}
