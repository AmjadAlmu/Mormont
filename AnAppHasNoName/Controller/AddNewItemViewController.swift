//
//  AddNewItemViewController.swift
//  AnAppHasNoName
//
//  Created by Amjad Almuwallad on 09/02/2019.
//  Copyright © 2019 Amjad. All rights reserved.
//

import UIKit

class AddNewItemViewController: UIViewController {

    @IBOutlet weak var stepIndicatorView: StepIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
