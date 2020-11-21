//  OrderSummaryVC.swift
//  OneBAncIos
//
//  Created by Shubham Tunwal on 21/11/20.
//

import UIKit
import  CoreData

class OrderSummaryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var totalAmtLabel: UILabel!
    
    var selectedItems:[String:Int]?
    var totalAmt:Int?
    
    var items:[String]?
    var prices:[Int]?
    
    @IBOutlet weak var ordersummTv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

//
//        selectedItems = [String:Int]()
        
        items = Array(selectedItems!.keys)
        prices = Array(selectedItems!.values)

        totalAmtLabel.text = "Total Amount " + "\(totalAmt!)"
        // Do any additional setup after loading the view.
        
        ordersummTv.delegate = self
        ordersummTv.dataSource = self
        
    }
  

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedItems!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderSumCell", for: indexPath)
        
        cell.textLabel?.text = "\(items![indexPath.row]) - \(prices![indexPath.row])"
        
        return cell
    }
    
    
    
    @IBAction func placeOrder(_ sender: UIButton) {
        let orderID = Int.random(in: 1000..<9999)
        
//        let alert = UIAlertController()
//        alert.title = "Order Confirmed"
//        alert.message = "Your order ID \(orderID) has been confirmed with Total Amount \(String(describing: totalAmt))"
//        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
//
//        alert.show(self, sender: nil)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Orders", in: context)
        let newOrder = NSManagedObject(entity: entity!, insertInto: context)
        
        newOrder.setValue(orderID, forKey: "orderId")
        newOrder.setValue(totalAmt, forKey: "amt")
        
        do {
           try context.save()
          } catch {
           print("Failed saving")
        }
        var alert = UIAlertController(title: "Order Confirmed", message: "Your order ID \(orderID) has been confirmed with Total Amount \(String(describing: totalAmt!))", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in
            
            // go back to the  view controller
            // go back through the navigation controller

       
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
           
            self.navigationController?.pushViewController(destination, animated: true)


        }))
        self.present(alert, animated: true, completion: nil)
        
        
        

        
        
    }
    
}
