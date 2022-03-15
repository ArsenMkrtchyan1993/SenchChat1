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
}
