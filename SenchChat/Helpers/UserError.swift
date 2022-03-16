//
//  UserError.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 10.03.22.
//

import Foundation


enum UserError {
    case notFilled
    case photoNotExist
    case conNotGetUserInfo
    case canNotUnwrapMUser
    
}

extension UserError: LocalizedError {
    
    var errorDescription: String? {
      
        switch self {
        case .notFilled:
            return NSLocalizedString("lracreq bolor dashtery", comment: "")
        case .photoNotExist:
            return NSLocalizedString("avelacreq nkar", comment: "")
        case .conNotGetUserInfo:
            return NSLocalizedString("chka senc user", comment: "")
        case .canNotUnwrapMUser:
            return NSLocalizedString("sxal firestor unwrap muser from document", comment: "")
        }
    }
}

