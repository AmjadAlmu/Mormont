//
//  MenuBarCollectionViewCell.swift
//  AnAppHasNoName
//
//  Created by Amjad on 27/10/2018.
//  Copyright © 2018 Amjad. All rights reserved.
//

import UIKit

class MenuBarCollectionViewCell: UICollectionViewCell {
    
    let itemType: UILabel = {
       let label = UILabel()
        label.textColor = Config.SECONDARY_COLOR
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            itemType.textColor = isHighlighted ? .white : Config.SECONDARY_COLOR
        }
    }
    
    override var isSelected: Bool {
        didSet {
            itemType.textColor = isSelected ? .white : Config.SECONDARY_COLOR
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
        
    }
    
    func setUpCell() {
        addSubview(itemType)
        itemType.widthAnchor.constraint(equalToConstant:  150).isActive = true
        itemType.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        itemType.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
