//
//  MMessage.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 16.03.22.
//

import UIKit
import FirebaseFirestore
import MessageKit


struct MMessage: Hashable, MessageType {
  
    
    var sender: SenderType
    let content: String
    let sentDate: Date
    let id: String?
    var messageId: String {
        return id ?? UUID().uuidString
    }
    var kind: MessageKind {
        return .text(content)
    }
     
    
    var representation: [String: Any] {
        let rep: [String: Any] =  [
            "created": sentDate,
            "senderId": sender.senderId,
            "senderUserName": sender.displayName ,
            "content": content
        ]
        return rep
    }
    
    init(user: MUser,content: String) {
        self.sender = Sender(senderId: user.id, displayName: user.userName)
        self.sentDate = Date()
        self.id = nil
        self.content = content
    }
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let senderId = data["senderId"] as? String,
        let senderUserName = data["senderUserName"] as? String,
        let sendDate = data["created"] as? Timestamp,
        let content = data["content"] as? String else { return nil }
         
        self.sender = Sender(senderId: senderId, displayName: senderUserName)
        self.sentDate = sendDate.dateValue()
        self.id = document.documentID
        self.content = content
    }
    
    static func == (lhs: MMessage, rhs: MMessage) -> Bool {
        return lhs.messageId == rhs.messageId
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }
    
}

extension MMessage: Comparable {
    static func < (lhs: MMessage, rhs: MMessage) -> Bool {
        lhs.sentDate < rhs.sentDate
    }
    
    
}
