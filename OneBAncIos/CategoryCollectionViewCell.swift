//
//  CategoryCollectionViewCell.swift
//  OneBAncIos
//
//  Created by Shubham Tunwal on 20/11/20.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
   
    
    
    @IBOutlet weak var ctgLabel: UILabel!
    @IBOutlet weak var categImg: UIImageView!
    
    @IBOutlet weak var categItems: UITableView!
    
    
    var menuItems:[String]?
    var menuItemsPrice:[String]?
    
    var categItem:CategoryDishes?

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if superview != nil {
            // Update the cell
            
            menuItems=[]
            menuItemsPrice=[]
          
            categItems.dataSource = self
            categItems.delegate = self
            
            ctgLabel.text = categItem?.category
            categImg.image = categItem?.img
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (categItem?.items!.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryDishesMenuCell", for: indexPath)

        var price:Double = Double(Array((categItem?.items)!)[indexPath.row].value)
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            // change label here
            price += price*Double(0.01)
            cell.textLabel?.text = Array((self.categItem?.items)!)[indexPath.row].key + "  -  Rs." + String(price)

        }
        
        
        return cell
    }
}
