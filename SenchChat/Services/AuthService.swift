//
//  AuthService.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 09.03.22.
//

import UIKit
import Firebase
import FirebaseAuth


class AuthService {
    static let shared = AuthService()
    private let auth = Auth.auth()
    func login(email: String?, password:String?, completion: @escaping (Result<User,Error>) -> Void) {
        guard let email = email,
        let password = password else {
            completion(.failure(AuthError.notFilled))
            return
        }
    auth.signIn(withEmail: email, password: password) { result, error in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
            
        }
    }
    
    func register(email: String?, password:String?, confirmPass:String?, completion: @escaping (Result<User,Error>) -> Void) {
        
       
        guard Validators.isFilled(email:email, password: password, conformPassword: confirmPass) else {
            completion(.failure(AuthError.notFilled))
            return
        }
        guard password?.lowercased() == confirmPass?.lowercased() else {
            completion(.failure(AuthError.passwordNotMatched))
            return
        }
        guard Validators.isSimpleEmail(email!) else {
            completion(.failure(AuthError.invalidEmail))
            return
        }
        auth.createUser(withEmail: email!, password: password!) { result, error in
           
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
}
