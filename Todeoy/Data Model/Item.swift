//
//  Item.swift
//  Todeoy
//
//  Created by Jaouad Hoummass on 2/16/19.
//  Copyright © 2019 Jaouad Hoummass. All rights reserved.
//

import Foundation

class Item : NSObject,NSCoding {
    
    var title:String?
    var checked:Bool?
    
    init(t: String, d: Bool) {
        self.title = t
        self.checked = d
        
    }
    
    // MARK: - NSCoding
    required init(coder aDecoder: NSCoder) {
        
        title = aDecoder.decodeObject(forKey: "title") as? String
        checked = aDecoder.decodeObject(forKey: "checked") as? Bool
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(checked, forKey: "checked")
    }
}
