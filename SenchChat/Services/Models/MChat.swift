//
//  MChat.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 05.03.22.
//

import UIKit
import FirebaseFirestore


struct MChat:Hashable,Decodable {
    
    var friendUserName:String
    var friendImageString:String
    var lastMessage:String
    var friendId: String
    
    var representation: [String: Any] {
        var rep = ["friendUserName": friendUserName]
        rep["friendImageString"] =  friendImageString
        rep["lastMessage"] = lastMessage
        rep["friendId"] = friendId
        return rep
    }
    init(friendUserName: String,friendImageString: String, lastMessage: String,friendId: String) {
        self.friendUserName = friendUserName
        self.friendImageString = friendImageString
        self.lastMessage = lastMessage
        self.friendId = friendId
    }
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let friendUserName = data["friendUserName"] as? String,
        let friendImageString = data["friendImageString"] as? String,
        let friendId = data["friendId"] as? String,
        let lastMessage = data["lastMessage"] as? String else { return nil }
        
        self.friendUserName = friendUserName
        self.friendImageString = friendImageString
        self.friendId = friendId
        self.lastMessage = lastMessage
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(friendId)
    }
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        return lhs.friendId == rhs.friendId
    }

}
