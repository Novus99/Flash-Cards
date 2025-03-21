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
    
    let authRegisterService = AuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authRegisterService.registerDelegate = self
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, !email.isEmpty, !password.isEmpty else {
            print("Email and password cannot be empty!")
            return
        }
        
        authRegisterService.registerUser(email: email, password: password)
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


