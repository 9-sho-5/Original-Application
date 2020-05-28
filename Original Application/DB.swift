//
//  Memo.swift
//  Original Application
//
//  Created by Kusunose Hosho on 2020/05/24.
//  Copyright © 2020 Kusunose Hosho. All rights reserved.
//

import Foundation
import RealmSwift

class Memo: Object {
    @objc dynamic var id: Int = 1
    @objc dynamic var textedMemo: String = ""
}

class Folder: Object {
    @objc dynamic var id: Int = 1
    @objc dynamic var name: String = ""
    @objc dynamic var date: Date!
    
    //１対多の関係
    let lotsMemo = List<Memo>()
}
