//
//  MenuBarCollectionViewCell.swift
//  AnAppHasNoName
//
//  Created by Amjad on 27/10/2018.
//  Copyright © 2018 Amjad. All rights reserved.
//

import UIKit

class MenuBarCollectionViewCell: UICollectionViewCell {
    
    let itemLabel: UILabel = {
       let label = UILabel()
        label.textColor = Config.SECONDARY_COLOR
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            itemLabel.textColor = isHighlighted ? .white : Config.SECONDARY_COLOR
        }
    }
    
    override var isSelected: Bool {
        didSet {
            itemLabel.textColor = isSelected ? .white : Config.SECONDARY_COLOR
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
        
    }
    
    func setUpCell() {
        addSubview(itemLabel)
        itemLabel.widthAnchor.constraint(equalToConstant:  150).isActive = true
        itemLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        itemLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
