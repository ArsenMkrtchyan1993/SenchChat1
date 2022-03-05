//
//  SectionHeader.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 04.03.22.
//

import UIKit


class SectionHeader: UICollectionReusableView {
    
    static let reuseId = "SectionHeader"
    let  title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
    }
    func  configure(text: String, font: UIFont?, color:UIColor) {
        title.text = text
        title.font = font
        title.textColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
