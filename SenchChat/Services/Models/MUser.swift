//
//  MUser.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 05.03.22.
//

import UIKit

struct MUser: Hashable,Decodable{
    
    var username: String
    var email: String
    var description: String
    var avatarStringURL: String
    var id: String
    var sex: String?
    var representation:[String:Any] {
        var rep = ["userName": username]
        rep["sex"] = sex
        rep["email"] = email
        rep["description"] = description
        rep["uid"] = id
        rep["avatarStringURL"] = avatarStringURL
        return rep
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: MUser, rhs: MUser) -> Bool {
        return lhs.id == rhs.id
    }
    
    func contains(filter:String?) -> Bool {
        guard let filter = filter else {return true}
        if filter == " " || filter == "  " {return true}
        if filter.isEmpty { return true}
        let lowercasedFilter = filter.lowercased()
        return username.lowercased().contains(lowercasedFilter)

    }
    
}


