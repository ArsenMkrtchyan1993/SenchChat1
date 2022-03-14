//
//  AuthService.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 09.03.22.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn





class AuthService {
    static let shared = AuthService()
    private let auth = Auth.auth()
    private var verificationId: String?
    
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
    
    func googleLogin(user: GIDGoogleUser!,error: Error!,completion: @escaping (Result<User,Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
            return
        }
        guard
          let authentication = user?.authentication,
          let idToken = authentication.idToken
        else {
          return
        }

        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { result, error in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
    func phoneRegister(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationId, error in
            guard let verificationId = verificationId, error == nil else {
                completion(false)
                return
            }
            self.verificationId = verificationId
            completion(true)
        }
        
    }
    
    func verifyCode(smsCode: String,completion: @escaping (Result<User,Error>) -> Void) {
        guard let verificationId = verificationId else {
            return
        }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: smsCode)
        Auth.auth().signIn(with: credential) { result, error in
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
