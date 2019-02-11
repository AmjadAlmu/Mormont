//
//  MenuBar.swift
//  AnAppHasNoName
//
//  Created by Amjad on 26/10/2018.
//  Copyright © 2018 Amjad. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var menuBarItems: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = Config.MAIN_COLOR
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "menuBarItems"
    let menuBarItemsLabels = ["Movies","TV Serieses","Books"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        menuBarItems.register(MenuBarCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(menuBarItems)
        addConstraintsWithFormat("H:|[v0]|", views: menuBarItems)
        addConstraintsWithFormat("V:|[v0]|", views: menuBarItems)
        
        //Making the middle cell selected
        let selectedCell = IndexPath(item: 1, section: 0)
        menuBarItems.selectItem(at: selectedCell, animated: false, scrollPosition: .bottom)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuBarItems.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuBarCollectionViewCell
        cell.itemLabel.text = menuBarItemsLabels[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 3, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
