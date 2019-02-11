//
//  TabBarSettings.swift
//  AnAppHasNoName
//
//  Created by Amjad on 28/10/2018.
//  Copyright © 2018 Amjad. All rights reserved.
//

import UIKit

class TabBarSettings: UITabBar {
    private var addNewItemButton = UIButton()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tintColor = Config.MAIN_COLOR
        setupAddNewItemButton()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.isHidden {
            return super.hitTest(point, with: event)
        }
        
        let from = point
        let to = addNewItemButton.center
        
        return sqrt((from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)) <= 39 ? addNewItemButton : super.hitTest(point, with: event)
    }
    
    func setupAddNewItemButton() {
        //TODO: Add glow to the button "MAY NOT"
        addNewItemButton.frame.size = CGSize(width: 70, height: 70)
        addNewItemButton.backgroundColor = Config.MAIN_COLOR
        addNewItemButton.layer.cornerRadius = 35
        addNewItemButton.layer.masksToBounds = true
        addNewItemButton.setTitle("+", for: .normal)
        addNewItemButton.titleLabel?.font = .systemFont(ofSize: 65)
        addNewItemButton.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 3.0, bottom: 10.0, right: 0.0)
        addNewItemButton.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: 0)
        addNewItemButton.addTarget(self, action: #selector(openAddNewItemViewController), for: .touchUpInside)
        addSubview(addNewItemButton)
    }
    
    @objc func openAddNewItemViewController() {
                print("Test")
        if let delegate = self.delegate as? UITabBarController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let addNewItemVC = storyboard.instantiateViewController(withIdentifier: "AddNewItemViewControllerNav")
            delegate.present(addNewItemVC, animated: true, completion: nil)
        }
        
    }
}
