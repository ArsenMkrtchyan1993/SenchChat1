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
   
    func hash(into hasher: inout Hasher) {
        hasher.combine(friendId)
    }
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        return lhs.friendId == rhs.friendId
    }

}
