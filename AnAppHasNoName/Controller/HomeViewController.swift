//
//  HomeViewController.swift
//  AnAppHasNoName
//
//  Created by Amjad on 26/10/2018.
//  Copyright © 2018 Amjad. All rights reserved.
//

import UIKit
import MBProgressHUD

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    private var items = [Item]()
    private let reuseIdentifier = "itemcollectionViewCell"
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeViewController = self
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    
    private var itemsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "Home"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpMenuBar()
        setUpItemsCollectionView()
        loadItemsToCollectionView(selectedType: Config.TV_SERIESES_ENDPOINT)//TODO: Change it based on current selected cell
    }
    
    private func setUpMenuBar() {
        view.addSubview(menuBar)
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive =  true
        menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setUpItemsCollectionView() {
        itemsCollectionView = {
            let layout = UICollectionViewFlowLayout()
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.register(itemCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.backgroundColor = .white
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            return collectionView
        }()
        
        view.addSubview(itemsCollectionView)
        itemsCollectionView.topAnchor.constraint(equalTo: menuBar.bottomAnchor, constant: 0).isActive = true
        itemsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive =  true
        itemsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        itemsCollectionView.heightAnchor.constraint(equalToConstant: view.bounds.height - ((tabBarController?.tabBar.frame.size.height)! * 2)).isActive = true //TODO: Add footer or whatever to fix it
    }
    
    private func loadItemsToCollectionView(selectedType: String) {
        let progressHUD = MBProgressHUD.showAdded(to: view, animated: true)
        progressHUD.label.text = "Loading"
        items.removeAll()
        itemsCollectionView.reloadData()
        ServerManger.loadItemsDataFromDatabase(selectedType: selectedType) { (item) in
            self.items.append(item)
            self.itemsCollectionView.reloadData()
            progressHUD.hide(animated: true)
        }
        
    }
    
    func selectedTypeCell(selectedType: String) {
        loadItemsToCollectionView(selectedType: selectedType)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! itemCollectionViewCell
        let item = items[indexPath.row]
        cell.item = item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / 2 - 15
        return CGSize(width: width , height: width + (width*0.25) )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showItemSeasons", sender: (items[indexPath.row].id, items[indexPath.row].type))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let itemDetailsVC = segue.destination as? ItemDetailsController {
            let dataToBeSent = sender as! (itemId: String, itemType: String)
            itemDetailsVC.itemId = dataToBeSent.itemId
            itemDetailsVC.itemType = dataToBeSent.itemType
        }
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        //TODO: Move this button to user's profile
        let progressHUD = MBProgressHUD.showAdded(to: view, animated: true)
        progressHUD.label.text = "Please wait"
        //TODO: Asking user if he is sure about logging out by alert
        ServerManger.logOut(onSuccess: {
            progressHUD.hide(animated: true)
            self.performSegue(withIdentifier: "SignInViewController", sender: nil)
        }) { (error) in
            progressHUD.hide(animated: true)
            Config.displayAlert(self, title: "Error", message: error!)
        }
    }
    
    
}
