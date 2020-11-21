//
//  CategoryDishes.swift
//  OneBAncIos
//
//  Created by Shubham Tunwal on 20/11/20.

import Foundation
import UIKit

class CategoryDishes:NSObject{
     init(category: String? = nil, items: [String : Int]? = nil, img: UIImage? = nil) {
        self.category = category
        self.items = items
        self.img = img
    }
    

    var category:String?
    var items:[String:Int]?
    var img:UIImage?
  
    
}
