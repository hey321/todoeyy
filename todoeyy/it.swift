//
//  it.swift
//  todoeyy
//
//  Created by Anas on 29/04/1440 AH.
//  Copyright © 1440 Anas. All rights reserved.
//

import Foundation
import RealmSwift
class itemb: Object {
    @objc dynamic var title = ""
    @objc dynamic var check = false
    @objc dynamic var datecreated: Date?
    let parent = LinkingObjects(fromType: caterg.self, property: "items")
    
}
