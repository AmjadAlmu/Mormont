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
    
    override func awakeFromNib() {
        addBlurEffect()
    }
    
    func setUpReusableView() {
        if let imageUrlString = item?.imageUrl {
            let imageUrl = URL(string: imageUrlString)
            itemImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: "image_placeholder"))
        }
        itemNameLabel.text = item?.name
        itemCaptionLabel.text = item?.caption
    }
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        addSubview(blurEffectView)
//        blurEffectView.fillSuperview()
        self.bringSubviewToFront(itemNameLabel)
        self.bringSubviewToFront(itemCaptionLabel)
    }
    
    
    
}
