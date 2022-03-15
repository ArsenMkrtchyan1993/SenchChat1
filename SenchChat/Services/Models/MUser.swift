//
//  MUser.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 05.03.22.
//

import UIKit
import FirebaseFirestore

struct MUser: Hashable,Decodable{
    
    var userName: String
    var email: String
    var description: String
    var avatarStringURL: String
    var id: String
    var sex: String?
    var phoneNumber:String
    
    init?(document: DocumentSnapshot)  {
        guard let data = document.data() else { return nil }
        guard let userName = data["userName"] as? String else { return nil }
        guard let email = data["email"] as? String else { return nil }
        guard let avatarStringURL = data["avatarStringURL"] as? String else { return nil }
        guard let sex = data["sex"] as? String else { return nil }
        guard let uid = data["uid"] as? String else { return nil }
        guard let description = data["description"] as? String else { return nil }
        guard let phoneNumber = data["phoneNumber"] as? String else { return nil }

        self.userName = userName
        self.email = email
        self.id = uid
        self.sex = sex
        self.description = description
        self.avatarStringURL = avatarStringURL
        self.phoneNumber = phoneNumber
    }
    init?(document: QueryDocumentSnapshot)  {
        let data = document.data()
        guard let userName = data["userName"] as? String else { return nil }
        guard let email = data["email"] as? String else { return nil }
        guard let avatarStringURL = data["avatarStringURL"] as? String else { return nil }
        guard let sex = data["sex"] as? String else { return nil }
        guard let uid = data["uid"] as? String else { return nil }
        guard let description = data["description"] as? String else { return nil }
        guard let phoneNumber = data["phoneNumber"] as? String else { return nil }

        self.userName = userName
        self.email = email
        self.id = uid
        self.sex = sex
        self.description = description
        self.avatarStringURL = avatarStringURL
        self.phoneNumber = phoneNumber
    }
    
    init(userName: String,phoneNumber: String, email: String,avatarStringURL: String,sex: String,id: String,description: String) {
        self.userName = userName
        self.email = email
        self.id = id
        self.sex = sex
        self.description = description
        self.avatarStringURL = avatarStringURL
        self.phoneNumber = phoneNumber
        
    }
    var representation:[String:Any] {
        var rep = ["userName": userName]
        rep["sex"] = sex
        rep["email"] = email
        rep["description"] = description
        rep["uid"] = id
        rep["avatarStringURL"] = avatarStringURL
        rep["phoneNumber"] = phoneNumber
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
        return userName.lowercased().contains(lowercasedFilter)

    }
    
}


