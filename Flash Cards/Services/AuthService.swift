//
//  AuthService.swift
//  Flash Cards
//
//  Created by Novus on 21/03/2025.
//

import FirebaseAuth

protocol AuthServiceDelegate: AnyObject {
    func didRegisterSuccessfully()
    func didFailToRegister(with error: Error)
}

class AuthService {
    weak var delegate: AuthServiceDelegate?
    
    func registerUser(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password){ [weak self] authResult, error in
            if let e = error {
                self?.delegate?.didFailToRegister(with: e)
            }
            else {
                self?.delegate?.didRegisterSuccessfully()
            }
        }
    }
}
