//
//  Category.swift
//  Todoey
//
//  Created by Novica Petrovic on 11/08/2018.
//  Copyright © 2018 Novica Petrovic. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var colour: String = ""
    let items = List<Item>()
    
}

