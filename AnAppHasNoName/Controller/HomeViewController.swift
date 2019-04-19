//
//  HomeViewController.swift
//  AnAppHasNoName
//
//  Created by Amjad on 26/10/2018.
//  Copyright © 2018 Amjad. All rights reserved.
//

import UIKit
import MBProgressHUD

class HomeViewController: UIViewController {
    
    private var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "Home"
        
        setUpMenuBar()
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setUpMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat("V:|[v0(50)]", views: menuBar)
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        //TODO: Move this button to user's profile
        let progressHUD = MBProgressHUD.showAdded(to: view, animated: true)
        progressHUD.label.text = "Please wait"
        //TODO: Asking user if he is sure about logging out by alert
        ServerManger.logOut(onSuccess: {
            progressHUD.hide(animated: true)
            self.performSegue(withIdentifier: "SignInViewController", sender: nil)
        }) { (error) in
            progressHUD.hide(animated: true)
            Config.displayAlert(self, title: "Error", message: error!)
        }
    }
    
    
}
