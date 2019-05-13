//
//  Item.swift
//  AnAppHasNoName
//
//  Created by Amjad on 28/10/2018.
//  Copyright © 2018 Amjad. All rights reserved.
//

import UIKit

class Item: NSObject {
    var id: String?
    var name: String?
    var caption: String?
    var imageUrl: String?
    var seasonsCount: Int?
    var uid: String?
    var date: String?
    var type: String?
    
}

extension Item {
    static func transformItem(dict: [String: Any], type: String, key: String) -> Item {
        let item = Item()
        item.id = key
        item.name = dict["name"] as? String
        item.caption =  dict["caption"] as? String
        item.imageUrl = dict["imageUrl"] as? String
        item.seasonsCount = dict["seasonsCount"] as? Int
        item.uid = dict["uid"] as? String
        item.date = dict["date"] as? String
        item.type = type
        return item
    }
}
