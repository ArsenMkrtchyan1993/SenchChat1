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
    func getUserData(user: User, completion: @escaping (Result<MUser,Error>) -> Void) {
        
        let docRef = usersRef.document(user.uid)
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                guard let mUser = MUser(document: document) else {
                    completion(.failure(UserError.canNotUnwrapMUser))
                    return
                }
                completion(.success(mUser))
            } else {
                completion(.failure(UserError.conNotGetUserInfo))
            }
        }
        
    }
    func saveProfileWith(id: String, phoneNumber: String,email: String,userName: String?,avatarImageString:String?,description:String?,sex: String?,completion: @escaping (Result<MUser,Error>) -> Void) {
        guard Validators.isFilled(userName: userName, description: description, sex: sex) else {
            completion(.failure(UserError.notFilled))
            return
        }
        
        let mUser = MUser(userName: userName!,
                          phoneNumber: phoneNumber,
                          email: email,
                          avatarStringURL: description!,
                          sex: "not exist",
                          id: id,
                          description:sex!)
        
        self.usersRef.document(mUser.id).setData(mUser.representation) { error in
            if let error = error {
                completion(.failure(error))
            }else {
                completion(.success(mUser))
            }
        }
        
    }
    
}
