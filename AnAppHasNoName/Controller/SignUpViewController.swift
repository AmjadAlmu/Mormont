//
//  SignUpViewController.swift
//  AnAppHasNoName
//
//  Created by Amjad on 24/10/2018.
//  Copyright © 2018 Amjad. All rights reserved.
//

import UIKit
import MBProgressHUD

class SignUpViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: Unable sign up button when text are fields empty
        //        signupButtonOutlet.isEnabled = false
        //        handleTextField()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if ServerManger.sharedInstance.CURRENT_USER != nil {
            self.performSegue(withIdentifier: "signUpToTabbarVC", sender: nil)
        }
    }
    
    
    @IBAction func dismissViewController(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signupButton(_ sender: Any) {
        let progressHUD = MBProgressHUD.showAdded(to: view, animated: true)
        progressHUD.label.text = "Please wait"
        ServerManger.signUp(username: usernameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, onSuccess: {
            progressHUD.hide(animated: true)
            self.performSegue(withIdentifier: "signUpToTabbarVC", sender: self)
        }) { (error) in
            progressHUD.hide(animated: true)
            Config.displayAlertWithHandler(self, title: "Error", message: error!, handler: { (action) in
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
            })
        }
    }
    
    /*func handleTextField() {
     usernameTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
     
     }
     
     @objc func textFieldDidChange() {
     guard let username = usernameTextField.text, !username.isEmpty, let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
     signupButtonOutlet.backgroundColor = .black
     signupButtonOutlet.setTitleColor(.lightText, for: .normal)
     signupButtonOutlet.isEnabled = false
     return
     }
     signupButtonOutlet.setTitleColor(.lightText, for: .normal)
     signupButtonOutlet.isEnabled = true
     }*/
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
