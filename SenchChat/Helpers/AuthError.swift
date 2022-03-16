//
//  AuthError.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 09.03.22.
//

import Foundation
import SwiftUI


enum AuthError {
    case notFilled
    case invalidEmail
    case passwordNotMatched
    case unknownError
    case serverError
}

extension AuthError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
            
        case .notFilled:
            return NSLocalizedString("lracreq dashtery", comment: "")
        case .invalidEmail:
            return NSLocalizedString("pochta sxal lracrat", comment: "")
        case .passwordNotMatched:
            return NSLocalizedString("sxal parol", comment: "")
        case .unknownError:
            return NSLocalizedString("unknown error", comment: "")
        case .serverError:
            return NSLocalizedString("server error", comment: "")
        }
    }
}

