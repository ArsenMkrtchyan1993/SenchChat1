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
        if let image = image {
            let mediaItem = ImageItem(url: nil, image: nil, placeholderImage: image, size: image.size)
            return .photo(mediaItem)
        } else {
        return .text(content)
        }
    }
    var image: UIImage? = nil
    var downloadUrl: URL? = nil
    
    
    var representation: [String: Any] {
        var rep: [String: Any] =  [
            "created": sentDate,
            "senderId": sender.senderId,
            "senderUserName": sender.displayName ,
        ]
        if let url = downloadUrl {
            rep["url"] = url.absoluteString
        } else {
            rep["content"] = content
        }
        return rep
    }
    
    init(user: MUser,content: String) {
        self.sender = Sender(senderId: user.id, displayName: user.userName)
        self.sentDate = Date()
        self.id = nil
        self.content = content
    }
    init(user: MUser, image: UIImage) {
        self.sender = Sender(senderId: user.id, displayName: user.userName)
        self.image = image
        content = ""
        self.sentDate = Date()
        id = nil
    }
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let senderId = data["senderId"] as? String,
        let senderUserName = data["senderUserName"] as? String,
        let sendDate = data["created"] as? Timestamp else { return nil }
        self.sentDate = sendDate.dateValue()
        self.sender = Sender(senderId: senderId, displayName: senderUserName)
        self.id = document.documentID
        if let content = data["content"] as? String {
            self.content = content
            downloadUrl = nil
        } else if let urlString = data["url"] as? String, let url = URL(string: urlString) {
            downloadUrl = url
            self.content = ""
        } else {
            return nil
        }
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
