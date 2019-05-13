//
//  ItemDetailsController.swift
//  AnAppHasNoName
//
//  Created by Amjad Almuwallad on 30/04/2019.
//  Copyright © 2019 Amjad. All rights reserved.
//

import UIKit
import MBProgressHUD

class ItemDetailsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var itemId = ""
    var itemType = ""
    var item = Item()
    var numberOfSeason = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = true
        collectionView.contentInsetAdjustmentBehavior = .never
        
    }
    
    override func willMove(toParent parent: UIViewController?) {
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadItem()
    }
    
    private func loadItem() {
        let progressHUD = MBProgressHUD.showAdded(to: view, animated: true)
        progressHUD.label.text = "Loading"
        ServerManger.loadItemDetailsFromDatabase(withItem: itemId, itemType: itemType) { (item) in
            self.item = item
            self.numberOfSeason = item.seasonsCount ?? 0
            self.collectionView.reloadData()
            progressHUD.hide(animated: true)
        }
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return numberOfSeason + 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeasonCollectionViewCell", for: indexPath) as! SeasonCollectionViewCell
        cell.cellNumber = indexPath.row + 1
        cell.item = item
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
        headerView.item = item
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / 2 - 50
        return CGSize(width: width , height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 25, bottom: 50, right: 25)
    }

}
