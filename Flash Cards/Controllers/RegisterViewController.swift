//
//  ViewController.swift
//  Flash Cards
//
//  Created by Novus on 20/03/2025.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmationPasswordTextField: UITextField!
    
    let authRegisterService = AuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authRegisterService.registerDelegate = self
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextField.text, !email.isEmpty,
           let password = passwordTextField.text, !password.isEmpty,
           let confirmationPassword = confirmationPasswordTextField.text, !confirmationPassword.isEmpty {
            
            if password == confirmationPassword {
                authRegisterService.registerUser(email: email, password: password)
            } else {
                print("Passwords do not match!")
            }
            
        } else {
            print("Email, password, or confirmation password cannot be empty!")
        }
    }
    
    
    
    
}

//MARK: - AuthRegisterDelegate Methods

extension RegisterViewController: AuthRegisterDelegate {
    
    func didRegisterSuccessfully() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: K.Navigation.registerSegue, sender: self)
        }
    }
    
    func didFailToRegister(with error: any Error) {
        DispatchQueue.main.async {
            print("Firebase auth error: \(error.localizedDescription)")
        }
    }
    
}


