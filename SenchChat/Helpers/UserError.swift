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
    
}

extension UserError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
            
        case .notFilled:
            return NSLocalizedString("lracreq bolor dashtery", comment: "")
        case .photoNotExist:
            return NSLocalizedString("avelacreq nkar", comment: "")
        }
    }
}

