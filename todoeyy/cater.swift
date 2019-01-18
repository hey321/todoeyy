//
//  cater.swift
//  todoeyy
//
//  Created by Anas on 29/04/1440 AH.
//  Copyright © 1440 Anas. All rights reserved.
//

import Foundation
import RealmSwift
class caterg: Object {
    @objc dynamic var names = ""
    @objc dynamic var color = ""
    let items = List<itemb>()
    
}
