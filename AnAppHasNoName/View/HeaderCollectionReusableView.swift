//
//  HeaderCollectionReusableView.swift
//  AnAppHasNoName
//
//  Created by Amjad Almuwallad on 30/04/2019.
//  Copyright © 2019 Amjad. All rights reserved.
//

import UIKit
import Kingfisher

class HeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemCaptionLabel: UILabel!
    
    var item: Item? {
        didSet {
            setUpReusableView()
        }
    }
    
    func setUpReusableView() {
        if let imageUrlString = item?.imageUrl {
            let imageUrl = URL(string: imageUrlString)
            itemImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: "image_placeholder"))
        }
        itemNameLabel.text = item?.name
        itemCaptionLabel.text = item?.caption
    }
    
    
    
}
