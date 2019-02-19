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
    
    private var isScrollViewInitialized = false
    
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
    
    private func initScrollView() {
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width * CGFloat(self.stepIndicatorView.numberOfSteps), height: self.scrollView.frame.height)
        
        for i in 1...self.stepIndicatorView.numberOfSteps {
            
            let scrollViewLabel: UILabel = {
                let label = UILabel()
                label.textAlignment = .center
                label.font = UIFont.systemFont(ofSize: 30) //TODO: Change font size in small screens "for iphone 5s"
                label.textColor = Config.MAIN_COLOR
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            self.scrollView.addSubview(scrollViewLabel)
            
            if i == 1{
                scrollViewLabel.text = "What do you wanna add?"
                let typesButtonTitles = ["Movie","TV Series","Book"]
                var typesButtonTopAnchor: CGFloat = 30
                var typesButtonTagIndex = 1
                
                for typesButtonTitle in typesButtonTitles {
                    let typesButton: UIButton = {
                        let button = UIButton()
                        button.backgroundColor = .white
                        button.setTitle("\(typesButtonTitle)", for: .normal)
                        button.setTitleColor(Config.MAIN_COLOR, for: .normal)
                        button.layer.cornerRadius = 15
                        button.tag = typesButtonTagIndex
                        button.translatesAutoresizingMaskIntoConstraints = false
                        button.addTarget(self, action: #selector(specifyWhichButtonWasClicked), for: .touchUpInside)
                        return button
                    }()
                    
                    self.scrollView.addSubview(typesButton)
                    typesButton.topAnchor.constraint(equalTo: scrollViewLabel.bottomAnchor, constant: typesButtonTopAnchor).isActive = true
                    typesButton.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 45).isActive = true
                    typesButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
                    typesButton.widthAnchor.constraint(equalToConstant: self.scrollView.frame.width - 90).isActive = true
                    typesButtonTopAnchor += 70
                    typesButtonTagIndex += 1
                }
                
            } else if i == 2 {
                scrollViewLabel.text = "What's its neme?"
                let itemNametextField: UITextField = {
                    let textField = UITextField()
                    textField.placeholder = "Type the name of it" //TODO: Replace the word 'it' with what the user choose
                    textField.textAlignment = .center
                    textField.tintColor = .white
                    textField.textColor = .white
                    textField.translatesAutoresizingMaskIntoConstraints = false
                    return textField
                }()
                self.scrollView.addSubview(itemNametextField)
                itemNametextField.topAnchor.constraint(equalTo: scrollViewLabel.bottomAnchor, constant: 30).isActive = true
                itemNametextField.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: self.scrollView.frame.width * CGFloat(i - 1) + 45).isActive = true
                itemNametextField.widthAnchor.constraint(equalToConstant: self.scrollView.frame.width - 90).isActive = true
                itemNametextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
                
            } else if i == 3 {
                scrollViewLabel.text = "Upload a picture of it" //TODO: Replace the word 'it' with what the user choose
            } else if i == 4 {
                scrollViewLabel.text = "test from four"
            } else {
                scrollViewLabel.text = "test from the last!"
            }
            
            
            scrollViewLabel.centerXAnchor.constraint(equalTo: self.scrollView.rightAnchor, constant: self.scrollView.frame.width / 2.0 * (CGFloat(i - 1) * 2.0 + 1.0)).isActive = true
            scrollViewLabel.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 5).isActive = true
        }
        
    }
    
    @objc func specifyWhichButtonWasClicked(sender:UIButton!) {
        print("Hi: \(sender.tag)")
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
