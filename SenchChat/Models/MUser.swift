//
//  MUser.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 05.03.22.
//

import UIKit

struct MUser: Hashable,Decodable{
    
    let username: String
    let avatarStringURL: String
    let id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: MUser, rhs: MUser) -> Bool {
        return lhs.id == rhs.id
    }
}



