//
//  FirestoreService.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 10.03.22.
//

import Foundation
import FirebaseFirestore
import Firebase

 
class FirestoreService {
    
    static let shared = FirestoreService()
    let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    func saveProfileWith(id: String, email: String,userName: String?,avatarImageString:String?,description:String?,sex: String?,completion: @escaping (Result<MUser,Error>) -> Void) {
        guard Validators.isFilled(userName: userName, description: description, sex: sex) else {
            completion(.failure(UserError.notFilled))
            return
        }
        
        let mUser = MUser(username: userName!,
                          email: email,
                          description: description!,
                          avatarStringURL: "not exist",
                          id: id,
                          sex:sex!)
        
        self.usersRef.document(mUser.id).setData(mUser.representation) { error in
            if let error = error {
                completion(.failure(error))
            }else {
                completion(.success(mUser))
            }
        }
        
    }
    
}
