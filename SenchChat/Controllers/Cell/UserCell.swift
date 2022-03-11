//
//  UserCell.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 05.03.22.
//

import UIKit


class UserCell: UICollectionViewCell,SelfConfiguringCell {
    
    
    
    static var reuseId: String = "UserCell"
    let userName = UILabel(title: "text", font: .laoSangamMN20())
    var userImageView = UIImageView()
    let containerView = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupConstraints()
        
        self.layer.cornerRadius = 4
        
        self.layer.shadowColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.containerView.layer.cornerRadius = 4
        self.containerView.clipsToBounds = true
    }
    
    
    
     func configure<U>(whit value: U) where U : Hashable {
         guard let user: MUser  = value as? MUser else { return }
         userName.text = user.userName
         userImageView.image = UIImage(named: user.avatarStringURL)
     }
  
    
    private func setupConstraints() {
        userName.translatesAutoresizingMaskIntoConstraints = false
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.backgroundColor = .orange
   
        containerView.addSubview(userImageView)
        containerView.addSubview(userName)
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            userImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            userImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            userImageView.heightAnchor.constraint(equalTo: containerView.widthAnchor)
        ])
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: userImageView.bottomAnchor),
            userName.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 10),
            userName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -10),
            userName.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

    }
    
 
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
