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
    @objc dynamic var folderId: Int = 1
    @objc dynamic var folderCheckingId: Int = 2
    @objc dynamic var date: Date!
    let folder = LinkingObjects(fromType: Folder.self, property: "memos")
}

class Folder: Object {
    @objc dynamic var id: Int = 1
    @objc dynamic var name: String = ""
    @objc dynamic var date: Date!
    
    //１対多の関係
    let memos = List<Memo>()
}
