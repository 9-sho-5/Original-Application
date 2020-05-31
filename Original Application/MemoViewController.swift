//
//  ViewController.swift
//  Original Application
//
//  Created by Kusunose Hosho on 2020/05/19.
//  Copyright © 2020 Kusunose Hosho. All rights reserved.
//

import UIKit
import RealmSwift

class MemoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var table: UITableView!
    
    var models: [Int] = []
    
    var memos: Results<Memo>!
    var folders: Results<Folder>!

    var memoNumber: Int = 0
    var memoId: Int!
    
    var folderId: Int!
    var currentFolderId: Int = 1
    
    var changedText: String!
    
    @IBOutlet var editButton: UIBarButtonItem!
    
    let realm = try! Realm()
    
    var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(FieldTableViewCell.nib(), forCellReuseIdentifier: FieldTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        
        let realm = try! Realm()
        memos = realm.objects(Memo.self)
        
//        .filter("folderCheckingId > folderId")
        
        folders = realm.objects(Folder.self)
        
        notificationToken = memos.observe { [weak self] _ in
            self?.table.reloadData()
        }
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
////        let realm = try! Realm()
////        memos = realm.objects(Memo.self).filter("folderCheckingId == folderId")
////        folders = realm.objects(Folder.self)
//
//        let memo = Memo()
//
//        if currentFolderId > 1{
//            currentFolderId = currentFolderId + 1
//        }
//
//        memoId = memo.id + 1
//        print(currentFolderId)
//    }
    
    

    // TableViewに表示するセルの数を返却します。
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return memos.count
    }

//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = models[indexPath.row]
//        cell.textLabel?.font = UIFont(name: "Arial", size: 22)
//        return cell
//    }
    
    //指定されたセルがテーブルから削除されたとき
    func tableView(_ tableView: UITableView, didEndDisplaying: UITableViewCell, forRowAt: IndexPath) {
        if memos.count == 0{
            editButton.title = "Edit"
            table.isEditing = false
        }
        
        
    }
    
    //cellの移動
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        models.swapAt(sourceIndexPath.row, sourceIndexPath.row)
        
        let moveObjTmp = models[sourceIndexPath.row]
        models.remove(at: sourceIndexPath.row)
        models.insert(moveObjTmp, at: destinationIndexPath.row)
        
    }
    //cellの編集
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        guard editingStyle == .delete else {return}
//        print("delete")

        if (editingStyle == .delete) {
//            models.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//
            
        let realm = try! Realm()
        try! realm.write {
            realm.delete(self.memos[indexPath.row])
        }
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
    
    // 各セルを生成して返却 ,表示するcellの中身の設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let fieldCell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.identifier, for: indexPath) as! FieldTableViewCell
        
        let fieldCell = tableView.dequeueReusableCell(withIdentifier: "FieldTableViewCell", for: indexPath) as! FieldTableViewCell
        
//        memo.textedMemo = memos[indexPath.row].textedMemo
        
        
        
            //データベースの中身の表示
        fieldCell.field.text = memos[indexPath.row].textedMemo
        
        return fieldCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    @IBAction func didTapSort() {
//        let memo = Memo()
//        var modelsContent: Int!
//        var modelsContentNumber: Int = 0
        
        if table.isEditing {
            editButton.title = "Edit"
            
            //mapメソッドでmodelsの中を順番変更
            models = models.map({$0 + 1})
            print(models)

            
//            models.forEeach {
//                modelsContent = models[modelsContentNumber]
//                memo.id = modelsContentNumber
//                modelsContentNumber = modelsContentNumber + 1
//                return
//            }
            
            table.isEditing = false
            
        } else {
            editButton.title = "Done"
            table.isEditing = true
        }
        
        table.reloadData()
    }
    
//    func addCell(sender: AnyObject) {
//        print("追加")
//
//        // myItemsに追加.
//        models.add()
//
//        // TableViewを再読み込み.
//        table.reloadData()
//    }
    
    @IBAction func add() {
        let memo = Memo()
        
        if memos.count == 0 {
            memoId = 1
            memo.id = memos.count + 1
            memoId = memoId + 1
        } else if memos.count >= 1 {
            memo.id = Int(memoId)
            memoId = memoId + 1
        }
        
        print(memo.id)
        memo.textedMemo = ""
        
        memo.date = Date()
        
        if currentFolderId == 1 {
            memo.folderId = 1
            memo.folderCheckingId = 2
        } else if currentFolderId > 1 {
            memo.folderId = currentFolderId
            memo.folderCheckingId = currentFolderId + 1
        }
        
        models.append(memoNumber)
        print(memoNumber)
        memoNumber = memoNumber + 1
        
        try! realm.write {
            realm.add(memo)
        }
        
        
    }
    
    @IBAction func save() {
        let folder = Folder()
        
        if folders.count == 0 {
            folderId = 1
            
            folder.id = folders.count + 1
            folderId = folderId + 1
        } else if folders.count >= 1 {
            folder.id = Int(folderId)
            folderId = folderId + 1
        }
        
        try! realm.write {
            realm.add(folder)
        }
        
    }
    
    @IBAction func backComfirmatioin() {
        
    }
    
}

