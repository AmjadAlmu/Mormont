//
//  AddNewItemViewController.swift
//  AnAppHasNoName
//
//  Created by Amjad Almuwallad on 09/02/2019.
//  Copyright © 2019 Amjad. All rights reserved.
//

import UIKit

class AddNewItemViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var stepIndicatorView: StepIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var isScrollViewInitialized = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isScrollViewInitialized {
            isScrollViewInitialized = true
            self.initScrollView()
        }
    }
    
    func initScrollView() {
        //TODO: Refactoring "it have to use Auto Layout for all views to apply Localization"
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width * CGFloat(self.stepIndicatorView.numberOfSteps), height: self.scrollView.frame.height)
        
        for i in 1...self.stepIndicatorView.numberOfSteps {
            let scrollViewLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
            
            if i == 1{
                scrollViewLabel.text = "What do you wanna add?"
                
                let typesButtonTitles = ["Movie","TV Series","Book"]
                var buttonY: CGFloat = 80.0
                var tagIndex = 1
                
                for typesButtonTitle in typesButtonTitles {
                    let typesButton = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 35))
                    typesButton.center = CGPoint(x: self.scrollView.frame.width / 2.0 * (CGFloat(i - 1) * 2.0 + 1.0), y: buttonY)
                    typesButton.backgroundColor = .white
                    typesButton.setTitle("\(typesButtonTitle)", for: .normal)
                    typesButton.setTitleColor(Config.MAIN_COLOR, for: .normal)
                    typesButton.layer.cornerRadius = 15
                    typesButton.tag = tagIndex
                    typesButton.addTarget(self, action: #selector(specifyWhichButtonWasClicked), for: .touchUpInside)
                    self.scrollView.addSubview(typesButton)
                    buttonY += 70
                    tagIndex += 1
                }
                
            } else if i == 2 {
                scrollViewLabel.text = "What's its neme?"
            } else if i == 3 {
                scrollViewLabel.text = "Upload a picture of it" //TODO: Replace the word 'it' with what the user choose
            } else if i == 4 {
                scrollViewLabel.text = "test from four"
            } else {
                scrollViewLabel.text = "test from the last!"
            }
            
            scrollViewLabel.textAlignment = .center
            scrollViewLabel.font = UIFont.systemFont(ofSize: 30) //TODO: Change font size in small screens "for iphone 5s"
            scrollViewLabel.textColor = Config.MAIN_COLOR
            scrollViewLabel.center = CGPoint(x: self.scrollView.frame.width / 2.0 * (CGFloat(i - 1) * 2.0 + 1.0), y: 15.0)
            self.scrollView.addSubview(scrollViewLabel)
        }
        
    }
    
    @objc func specifyWhichButtonWasClicked(sender:UIButton!) {
//        print("Hi: \(sender.tag)")
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = scrollView.contentOffset.x / scrollView.frame.size.width
        stepIndicatorView.currentStep = Int(pageIndex)
    }
    
}
