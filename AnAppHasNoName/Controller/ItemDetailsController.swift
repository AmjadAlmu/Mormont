//
//  ItemDetailsController.swift
//  AnAppHasNoName
//
//  Created by Amjad Almuwallad on 30/04/2019.
//  Copyright © 2019 Amjad. All rights reserved.
//

import UIKit

class ItemDetailsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = true
        collectionView.contentInsetAdjustmentBehavior = .never
        
    }
    
    override func willMove(toParent parent: UIViewController?) {
        navigationController?.navigationBar.isTranslucent = false
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeasonCollectionViewCell", for: indexPath) as! SeasonCollectionViewCell
        cell.backgroundColor = Config.ITEM_COLLECTION_VIEW_CELL_COLOR
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerViewCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
        return headerViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / 2 - 50
        return CGSize(width: width , height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 25, bottom: 0, right: 25)
    }

}
