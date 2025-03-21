//
//  AuthService.swift
//  Flash Cards
//
//  Created by Novus on 21/03/2025.
//

import FirebaseAuth

protocol AuthRegisterDelegate: AnyObject {
    func didRegisterSuccessfully()
    func didFailToRegister(with error: Error)
}

protocol AuthLoginDelegate: AnyObject {
    func didLoginSuccessfully()
    func didFailToLogin(with error: Error)
}

class AuthService {
    weak var registerDelegate: AuthRegisterDelegate?
    weak var loginDelegate: AuthLoginDelegate?
    
    func registerUser(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password){ [weak self] authResult, error in
            if let e = error {
                self?.registerDelegate?.didFailToRegister(with: e)
            }
            else {
                self?.registerDelegate?.didRegisterSuccessfully()
            }
        }
    }
    
    func loginUser(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password){ [weak self] authResult, error in
            if let e = error {
                self?.loginDelegate?.didFailToLogin(with: e)
            }
            else {
                self?.loginDelegate?.didLoginSuccessfully()
            }
        }
    }
    
}
