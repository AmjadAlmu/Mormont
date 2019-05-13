//
//  SeasonCollectionViewCell.swift
//  AnAppHasNoName
//
//  Created by Amjad Almuwallad on 03/05/2019.
//  Copyright © 2019 Amjad. All rights reserved.
//

import UIKit

class SeasonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var seasonNumberLabel: UILabel!
    
    var cellNumber = Int()
    var item: Item? {
        didSet {
            setUpCell()
        }
    }
    
    func setUpCell() {
        self.backgroundColor = Config.ITEM_COLLECTION_VIEW_CELL_COLOR
        let seasonNumber = item?.seasonsCount ?? 0
        
        if cellNumber > seasonNumber && seasonNumber != 0{
            seasonNumberLabel.text = "Add +"
            seasonNumberLabel.textColor = .lightGray
            seasonNumberLabel.font = .systemFont(ofSize: 25)
        } else {
            seasonNumberLabel.text = "Season \(cellNumber)"
        }
    }
    
}
