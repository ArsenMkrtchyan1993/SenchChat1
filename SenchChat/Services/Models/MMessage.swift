//
//  MMessage.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 16.03.22.
//

import UIKit


struct MMessage: Hashable {
    let content: String
    let senderId: String
    let senderUserName: String
    let sendDate: Date
    let id: String?
    var representation: [String: Any] {
        let rep: [String: Any] =  [
            "created": sendDate,
            "senderId": senderId,
            "senderUserName": senderUserName,
            "content": content
        ]
        return rep
    }
    
    init(user: MUser,content: String) {
        self.senderId = user.id
        self.senderUserName = user.userName
        self.sendDate = Date()
        self.id = nil
        self.content = content
    }
    
    
}
