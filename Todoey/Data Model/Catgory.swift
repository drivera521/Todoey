//
//  Catgory.swift
//  Todoey
//
//  Created by Daniel Rivera on 12/5/20.
//  Copyright © 2020 Daniel Rivera. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    let items = List<Item>()
    
    
}
