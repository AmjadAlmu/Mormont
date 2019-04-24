//
//  itemCollectionViewCell.swift
//  AnAppHasNoName
//
//  Created by Amjad Almuwallad on 21/04/2019.
//  Copyright © 2019 Amjad. All rights reserved.
//

import UIKit
import Kingfisher

class itemCollectionViewCell: UICollectionViewCell {

    let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let itemLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var item: Item? {
        didSet {
            setUpCell()
        }
    }
    
    func setUpCell() {
        addSubview(itemImageView)
        itemImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        itemImageView.widthAnchor.constraint(equalTo: widthAnchor, constant: -30).isActive = true
        itemImageView.heightAnchor.constraint(equalTo: widthAnchor, constant: -30).isActive = true
        itemImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(itemLabel)
        itemLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 10).isActive = true
        itemLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        itemLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        if let imageUrlString = item?.imageUrl {
            let imageUrl = URL(string: imageUrlString)
            itemImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "image_placeholder"))
        }
        
        if let itemName = item?.name {
            itemLabel.text = itemName
        }
    }
}
