//
//  WaitingChatNavigation.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 17.03.22.
//

import Foundation


protocol WaitingChatNavigation: AnyObject {
    func removeWaitingChat(chat: MChat)
    func chatToActive(chat: MChat)
}
