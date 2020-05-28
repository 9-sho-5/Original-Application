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

    var memoNumber: Int = 0
    var memoId: Int!
    
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
        
        notificationToken = memos.observe { [weak self] _ in
            self?.table.reloadData()
        }
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
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
        if table.isEditing {
                editButton.title = "Edit"
            table.isEditing = false
        } else {
                editButton.title = "Done"
            table.isEditing = true
        }
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
        
        models.append(memoNumber)
        print(memoNumber)
        memoNumber = memoNumber + 1
        
        try! realm.write {
            realm.add(memo)
        }
        
        
    }
    
}

