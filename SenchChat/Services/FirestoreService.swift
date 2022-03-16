//
//  FirestoreService.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 10.03.22.
//

import Foundation
import FirebaseFirestore
import Firebase
import UIKit

 
 class FirestoreService {
    
    static let shared = FirestoreService()
    let db = Firestore.firestore()
    var currentUser: MUser!
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
                self.currentUser = mUser
                completion(.success(mUser))
            } else {
                completion(.failure(UserError.conNotGetUserInfo))
            }
        }
        
    }
     
    func saveProfileWith(id: String, phoneNumber: String,email: String,userName: String?,avatarImage:UIImage?,description:String?,sex: String?,completion: @escaping (Result<MUser,Error>) -> Void) {
        guard Validators.isFilled(userName: userName, description: description, sex: sex) else {
            completion(.failure(UserError.notFilled))
            return
        }
        // check image 
        guard avatarImage != #imageLiteral(resourceName: "avatar") else {
            completion(.failure(UserError.photoNotExist))
            return
        }
                
        var mUser = MUser(userName: userName!,
                          phoneNumber: phoneNumber,
                          email: email,
                          avatarStringURL: "not exise",
                          sex: sex!,
                          id: id,
                          description:description!)
        StorageService.shared.upload(photo: avatarImage!) { result in
            switch result {
                
            case .success(let url):
                mUser.avatarStringURL = url.absoluteString
                self.usersRef.document(mUser.id).setData(mUser.representation) { error in
                    if let error = error {
                        completion(.failure(error))
                    }else {
                        completion(.success(mUser))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        } //StorageService
    }//saveProfileWith
     
     func createWaitingChat(message: String, receiver: MUser,completion: @escaping (Result<Void,Error>) -> Void) {
         
         let reference = db.collection(["users",receiver.id,"waitingChats"].joined(separator: "/"))
         let messageRef = reference.document(self.currentUser.id).collection("messages")
         let message = MMessage(user: currentUser, content: message)
         
         let chat = MChat(friendUserName: currentUser.userName, friendImageString: currentUser.avatarStringURL, lastMessage:message.content, friendId: currentUser.id)
         reference.document(currentUser.id).setData(chat.representation) { error in
             if let error = error {
                 completion(.failure(error))
                 return
             }
             messageRef.addDocument(data: message.representation) { error in
                 if let error = error {
                     completion(.failure(error))
                     return
                 }
                completion(.success(Void()))
             }
             
         }
     }
    
}
