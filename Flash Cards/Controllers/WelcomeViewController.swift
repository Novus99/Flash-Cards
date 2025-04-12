//
//  ViewController.swift
//  Flash Cards
//
//  Created by Novus on 20/03/2025.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "\(K.appName)"
        // Do any additional setup after loading the view.
    }


}

