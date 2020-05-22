//
//  ViewController.swift
//  Original Application
//
//  Created by Kusunose Hosho on 2020/05/19.
//  Copyright © 2020 Kusunose Hosho. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var table: UITableView!

    var models: [Int] = []

    var memoNumber: Int = 0
    
    let saveData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(FieldTableViewCell.nib(), forCellReuseIdentifier: FieldTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = models[indexPath.row]
//        cell.textLabel?.font = UIFont(name: "Arial", size: 22)
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        models.swapAt(sourceIndexPath.row, sourceIndexPath.row)
        
        let moveObjTmp = models[sourceIndexPath.row]
        models.remove(at: sourceIndexPath.row)
        models.insert(moveObjTmp, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            models.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let fieldCell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.identifier, for: indexPath) as! FieldTableViewCell
            
            return fieldCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    @IBAction func didTapSort() {
        if table.isEditing {
            table.isEditing = false
        } else {
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
        models.append(memoNumber)
        print(memoNumber)
        memoNumber = memoNumber + 1
        
        table.reloadData()
    }
}

