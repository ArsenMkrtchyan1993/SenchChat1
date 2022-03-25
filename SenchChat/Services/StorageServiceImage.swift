//
//  StorageService.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 15.03.22.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class StorageService {
    
    static let shared  = StorageService()
    let storageRf = Storage.storage().reference()
    private var avatarsRf: StorageReference {
        return storageRf.child("avatars")
    }
    private var chatsRef: StorageReference {
        return storageRf.child("chats")
    }
    private var currentUserId: String {
        return Auth.auth().currentUser!.uid
    }
    func upload(photo: UIImage,completion: @escaping (Result<URL,Error>) -> Void) {
        guard let scaledImage = photo.scaledToSafeUploadSize, let imageData = scaledImage.jpegData(compressionQuality: 0.4) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        avatarsRf.child(currentUserId).putData(imageData, metadata: metaData) { metaData, error in
            guard let _ = metaData else {
                completion(.failure(error!))
                return
            }
            self.avatarsRf.child(self.currentUserId).downloadURL { url, error in
                guard let downloadURL = url else {
                    completion(.failure(error!))
                    return
            }
                completion(.success(downloadURL))
        }
    }
}
    func uploadImageMessage(photo: UIImage, to chat: MChat, completion: @escaping (Result<URL,Error>) -> Void) {
        guard let scaledImage = photo.scaledToSafeUploadSize, let imageData = scaledImage.jpegData(compressionQuality: 0.4) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        let imageName = [UUID().uuidString, String(Date().timeIntervalSince1970)].joined()
        let uid = Auth.auth().currentUser!.uid
        let chatName = [chat.friendUserName, uid].joined()
        self.chatsRef.child(chatName).child(imageName).putData(imageData, metadata: metaData) { metaData, error in
            guard let _ = metaData else {
                completion(.failure(error!))
                return
            }
            self.chatsRef.child(chatName).child(imageName).downloadURL { url, error in
                guard let downloadUrl = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(downloadUrl))
            }
        }
        
        
    }
    
    func downloadImage(url: URL, completion: @escaping (Result<UIImage?,Error>) -> Void) {
        let ref = Storage.storage().reference(forURL: url.absoluteString)
        let megaByte = Int64(1 * 1024 * 1024)
        ref.getData(maxSize: megaByte) { data, error in
            guard let imageData = data else {
                completion(.failure(error!))
                return
            }
            completion(.success(UIImage(data: imageData)))
        }
        
    }
}
