//  CategoryMenuViewController.swift
//  OneBAncIos
//  Created by Shubham Tunwal on 20/11/20.

import UIKit

class CategoryMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var totalAmtLabel: UILabel!
    var items:[String]?
    var prices:[Int]?
    
    var category:String?
    
    var menuITems:[String:Int]?

    
    var totalAmt = 0
    var selectedITems:[String:Int]?
    
    @IBOutlet weak var menuTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        categoryLabel.text = category
        
        if(category == "North Indian"){
            menuITems = ["Dal Tadka":149,"Kadai Paneer":179,"Kulcha":49,"Dum aloo":119]
        }
        else if(category == "South Indian"){
            menuITems = ["Dosa":49,"Idli":79,"Vada":55,"Biryani":155,"Curd Rice":105]
        }
        else if(category == "Italian"){
            menuITems = ["Pasta":249,"Pizza":179,"Risotto":55,"Soup":55,"Sandwhich":55]
        }
        else if(category == "Chinese"){
            menuITems = ["Chowmein":149,"Noodles":99,"Momos":155,"Fries":155,"Manchurian":139]
        }
        else if(category == "Mediterranian"){
            menuITems = ["Shawrama":179,"Falafel":89,"Cheeseballs":65,"Shakshuka":279,"Souvlaki":155]
        }
        
        selectedITems = [String:Int]()
        
        items = Array(menuITems!.keys)
        prices = Array(menuITems!.values)
        //        menuItemCell
        
        menuTV.delegate =  self
        menuTV.dataSource = self
    }
    
    
    
    var lastSelectedIndexPath = NSIndexPath(row: -1, section: 0)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuITems!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuItemCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel!.text = " \(Array(menuITems!.keys)[indexPath.row])  -  \(Array(menuITems!.values)[indexPath.row])"
        
        if cell.isSelected
        {
            cell.isSelected = false
            if cell.accessoryType == UITableViewCell.AccessoryType.none
            {
                cell.accessoryType = UITableViewCell.AccessoryType.checkmark
                
            }
            else
            {
                cell.accessoryType = UITableViewCell.AccessoryType.none
            }
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell!.isSelected
        {
            cell!.isSelected = false
            if cell!.accessoryType == UITableViewCell.AccessoryType.none
            {
                cell!.accessoryType = UITableViewCell.AccessoryType.checkmark
                
                totalAmt += prices![indexPath.row]
                
                totalAmtLabel.text = "Total Order Amount is Rs" + String(totalAmt)

                
                selectedITems!["\(Array(menuITems!.keys)[indexPath.row])"] = Array(menuITems!.values)[indexPath.row]
                
                print(selectedITems)
                
            }
            else
            {
                cell!.accessoryType = UITableViewCell.AccessoryType.none
                
                totalAmt -= prices![indexPath.row]

                totalAmtLabel.text = "Total Order Amount is Rs" + String(totalAmt)
                
                selectedITems?.removeValue(forKey: "\(Array(menuITems!.keys)[indexPath.row])")
                
                print(selectedITems)
            }
        }
    }
    @IBAction func toCheckout(_ sender: UIButton) {
        
        
        if(selectedITems?.count == 0){
            
            var alert = UIAlertController(title: "Invalid Selection", message: "Please Select at least 1 Item", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "OrderSummaryVC") as! OrderSummaryVC
            
            destination.selectedItems = selectedITems
            destination.totalAmt = totalAmt
            
            self.navigationController?.pushViewController(destination, animated: true)
            
        }
        

        
        
        

        
    }
    
    
    
}
