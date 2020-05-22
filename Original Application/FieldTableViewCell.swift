//
//  FieldTableViewCell.swift
//  Original Application
//
//  Created by Kusunose Hosho on 2020/05/23.
//  Copyright © 2020 Kusunose Hosho. All rights reserved.
//

import UIKit

class FieldTableViewCell: UITableViewCell, UITextFieldDelegate {

    static let identifier = "FieldTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "FieldTableViewCell", bundle: nil)
    }
    
    @IBOutlet var field: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        field.placeholder = "Write Somothing"
        field.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("\(textField.text ?? "")")
        return true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
