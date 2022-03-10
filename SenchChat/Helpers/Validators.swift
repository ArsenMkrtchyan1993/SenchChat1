//
//  Validators.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 09.03.22.
//

import Foundation


class Validators {
    
    static func isFilled(email:String?, password: String?,conformPassword:String?) -> Bool {
        guard let password = password,
              let email = email,
              let conformPassword = conformPassword,
                  password != "",
                  conformPassword != "",
              email != "" else { return false}
        return true
    }
    static func isFilled(userName:String?, description: String?,sex:String?) -> Bool {
        guard let description = description,
              let userName = userName,
              let sex = sex,
              description != "",
              sex != "",
              userName != "" else { return false}
        return true
    }
    static func isSimpleEmail(_ email:String) -> Bool {
        let emailPattern = #"^\S+@\S+\.\S+$"#
        return check(text: email, regEx: emailPattern)
    }
    private static func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
}
