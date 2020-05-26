//
//  FieldTableViewCell.swift
//  Original Application
//
//  Created by Kusunose Hosho on 2020/05/23.
//  Copyright © 2020 Kusunose Hosho. All rights reserved.
//

import UIKit
import RealmSwift

class FieldTableViewCell: UITableViewCell, UITextFieldDelegate {

    var table: UITableView!
    
    let realm = try! Realm()
    
    static let identifier = "FieldTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "FieldTableViewCell", bundle: nil)
    }
    
    @IBOutlet var field: UITextField!
    
    var addMemo: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        field.placeholder = "Write Somothing"
        field.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let memo = Memo()
        
//        print("\(textField.text ?? "")")

        addMemo = memo.textedMemo
        
        try! realm.write {
            // プロパティ値を変更することで
            // Realmに反映される
            memo.textedMemo = addMemo
        }
        
        textField.resignFirstResponder()
        
        return true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
