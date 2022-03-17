//
//  MMessage.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 16.03.22.
//

import UIKit
import FirebaseFirestore

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
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let senderId = data["senderId"] as? String,
        let senderUserName = data["senderUserName"] as? String,
        let sendDate = data["created"] as? Timestamp,
        let content = data["content"] as? String else { return nil }
        
        self.senderId = senderId
        self.senderUserName = senderUserName
        self.sendDate = sendDate.dateValue()
        self.id = document.documentID
        self.content = content
    }
    
    
}
