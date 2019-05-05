//
//  SeasonCollectionViewCell.swift
//  AnAppHasNoName
//
//  Created by Amjad Almuwallad on 03/05/2019.
//  Copyright © 2019 Amjad. All rights reserved.
//

import UIKit

class SeasonCollectionViewCell: UICollectionViewCell {
    
    var item: Item? {
        didSet {
            setUpCell()
        }
    }
    
    func setUpCell() {
        
    }
    
}
