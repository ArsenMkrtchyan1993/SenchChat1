//
//  WaitingChatCell.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 04.03.22.
//

import UIKit

class WaitingChatCell: UICollectionViewCell, SelfConfiguringCell {
   
    static var reuseId: String = "WaitingChatCell"
    let friendImageView = UIImageView()
    
   
   override init(frame:CGRect) {
        super.init(frame: frame)
       backgroundColor = .orange
       setupConstraints()
       self.layer.cornerRadius = 4
       self.clipsToBounds = true
    }
    
    
    
    func configure<U>(whit value: U) where U : Hashable {
        guard let chat: MChat  = value as? MChat else { return }
        friendImageView.image = UIImage(named: chat.userImageString)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup constraints
extension WaitingChatCell {
    
    
    private func setupConstraints() {
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(friendImageView)
        
        
        NSLayoutConstraint.activate([
            friendImageView.topAnchor.constraint(equalTo: self.topAnchor),
            friendImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            friendImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            friendImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
    }
    
    
    
}

        
        
        
        
// MARK: - SwiftUI


import SwiftUI

struct WaitingChatVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let tabBarVC = MainTabBarController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<WaitingChatVCProvider.ContainerView>) -> MainTabBarController {
            return tabBarVC
        }
        
        func updateUIViewController(_ uiViewController: WaitingChatVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<WaitingChatVCProvider.ContainerView>) {
            
        }
    }
}
