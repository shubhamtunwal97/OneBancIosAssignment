//
//  ViewController.swift
//  OneBAncIos
//
//  Created by Shubham Tunwal on 20/11/20.

import UIKit
import CoreData

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate{
   
    var pastOrders:[String:String]?
    
    var items:[String]?
    var prices:[String]?
    
    var categories:[CategoryDishes]?
    @IBOutlet weak var pastORdersTV: UITableView!
    
    @IBOutlet weak var categiriesCV: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        categories = []
        items = []
        prices = []
        
        pastORdersTV.dataSource = self
        pastORdersTV.delegate = self
        
        categories?.append(CategoryDishes(category: "North Indian", items: ["Dal Tadka":149,"Kadai Paneer":179,"Kulcha":49,"Dum aloo":119], img: UIImage(named: "north_indian")))
        categories?.append(CategoryDishes(category: "South Indian", items: ["Dosa":49,"Idli":79,"Vada":55,"Biryani":155,"Curd Rice":105], img: UIImage(named: "south_indian")))
        categories?.append(CategoryDishes(category: "Italian", items: ["Pasta":249,"Pizza":179,"Risotto":55,"Soup":55,"Sandwhich":55], img: UIImage(named: "italian")))
        categories?.append(CategoryDishes(category: "Chinese", items: ["Chowmein":149,"Noodles":99,"Momos":155,"Fries":155,"Manchurian":139], img: UIImage(named: "chinese")))
        categories?.append(CategoryDishes(category: "Mediterranian", items: ["Shawrama":179,"Falafel":89,"Cheeseballs":65,"Shakshuka":279,"Souvlaki":155], img: UIImage(named: "mediterrainian")))
        
        
        self.categiriesCV.showsHorizontalScrollIndicator = false
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Orders", in: context)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Orders")
                //request.predicate = NSPredicate(format: "age = %@", "12")
                request.returnsObjectsAsFaults = false
                do {
                    let result = try context.fetch(request)
                    for data in result as! [NSManagedObject] {
                        
                        print("\(data.value(forKey: "orderId")!)")
                        
                        items?.append("\(data.value(forKey: "orderId")!)")
                        prices?.append("\(data.value(forKey: "amt")!)")
                  }
                    
                } catch {
                    
                    print("Failed")
                }

    }


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        

        var index = indexPath.row
        
        cell.categItem = categories![index]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "CategoryMenuViewController") as! CategoryMenuViewController
        
        var index = indexPath.row

        destination.category = categories![index].category
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pastOrderCell", for: indexPath)
        
        
        cell.textLabel?.text = "Order ID #\(items![indexPath.row]) |  Order Amount is Rs.\(prices![indexPath.row])"

        return cell
    }
    
    
//    override func viewWillLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        let indexPath = IndexPath(item: 250, section: 0)
//        self.collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
//
//    }
//
    
}
