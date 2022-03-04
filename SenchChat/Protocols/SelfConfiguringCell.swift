//
//  SelfConfiguringCell.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 04.03.22.
//

import UIKit

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure(whit value: MChat)
}


