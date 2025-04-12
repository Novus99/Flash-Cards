//
//  ViewController.swift
//  Flash Cards
//
//  Created by Novus on 20/03/2025.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let authLoginService = AuthService()

    override func viewDidLoad() {
        super.viewDidLoad()
        authLoginService.loginDelegate = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginPressed(_ sender: RoundedButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, !email.isEmpty, !password.isEmpty else {
            print ("Please enter email and password")
            return
        }
        authLoginService.loginUser(email: email, password: password)
    }
    

}

//MARK: - AuthLoginDelegate Methods

extension LoginViewController: AuthLoginDelegate {
    func didLoginSuccessfully() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: K.Navigation.loginSegue, sender: self)
        }
    }
    
    func didFailToLogin(with error: any Error) {
        DispatchQueue.main.async {
            print("Firebase auth error: \(error)")
        }
    }
}

