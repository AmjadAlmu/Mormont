//
//  SignUpViewController.swift
//  AnAppHasNoName
//
//  Created by Amjad on 24/10/2018.
//  Copyright © 2018 Amjad. All rights reserved.
//

import UIKit

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
        ServerManger.signUp(username: usernameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, onSuccess: {
            self.performSegue(withIdentifier: "signUpToTabbarVC", sender: self)
        }) { (error) in
            //TODO: Refactoring
            print("The ERROR \(error)!!!!!!!!!!")
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
