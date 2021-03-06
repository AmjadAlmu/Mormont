//
//  LogInViewController.swift
//  AnAppHasNoName
//
//  Created by Amjad on 24/10/2018.
//  Copyright © 2018 Amjad. All rights reserved.
//

import UIKit
import MBProgressHUD

class LogInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if ServerManger.sharedInstance.CURRENT_USER != nil {
            self.performSegue(withIdentifier: "logInToTabbarVC", sender: nil)
        }
    }
    
    @IBAction func signInButton(_ sender: Any) {
        let progressHUD = MBProgressHUD.showAdded(to: view, animated: true)
        progressHUD.label.text = "Please wait"
        ServerManger.signIn(email: emailTextField.text!, password: passwordTextField.text!, onSuccess: {
            progressHUD.hide(animated: true)
            self.performSegue(withIdentifier: "logInToTabbarVC", sender: self)
        }) { (error) in
            progressHUD.hide(animated: true)
            Config.displayAlertWithHandler(self, title: "Error", message: error!, handler: { (action) in
                self.passwordTextField.text = ""
            })
        }
    }
    @IBAction func forgotPasswordButton(_ sender: Any) {
        //TODO: Complete it..
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
