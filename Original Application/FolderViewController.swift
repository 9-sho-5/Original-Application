//
//  FolderViewController.swift
//  Original Application
//
//  Created by Kusunose Hosho on 2020/05/24.
//  Copyright © 2020 Kusunose Hosho. All rights reserved.
//

import UIKit
import RealmSwift

class FolderViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    var models: [Int] = []
    
    var folderNumber: Int = 0
    
    var folderIdNumber: Int = 0
    
    let realm = try! Realm()
    let folders = try! Realm().objects(Folder.self).sorted(byKeyPath: "id")
    
    var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        
        layout.sectionInset = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        collectionView.collectionViewLayout = layout
        
        collectionView.register(FolderCollectionViewCell.nib(), forCellWithReuseIdentifier: FolderCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        notificationToken = folders.observe { [weak self] _ in
            self?.collectionView.reloadData()
        }
    }
    
    @IBAction func add() {
        
        let folder = Folder()
        
        folder.id = Int(folderIdNumber)
        folder.date = Date()
        
        models.append(folderNumber)
        print(folderNumber)
        folderNumber = folderNumber + 1
        
        try! realm.write {
            realm.add(folder)
        }
        
        folderIdNumber = folderIdNumber + 1
        
        collectionView.reloadData()
    }
        
    
}

extension FolderViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print("You tapped me")
    }
}


extension FolderViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FolderCollectionViewCell.identifier, for: indexPath) as! FolderCollectionViewCell
        
        cell.configure(with: UIImage(systemName: "folder")!)
        
        return cell
    }
}

extension FolderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
}
