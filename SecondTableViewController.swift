//
//  SecondTableViewController.swift
//  coreDataProject
//
//  Created by Puja Kumari on 4/18/17.
//  Copyright © 2017 nineleaps. All rights reserved.
//

import UIKit
import CoreData

class SecondTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var userArray = [String]()
    @IBOutlet weak var coredataTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.coredataTableView.delegate = self
         self.coredataTableView.dataSource = self
         self.fetchData()
         self.coredataTableView.reloadData()
       
    }
    
    func fetchData() {
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        do {
         let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
         let result = try context.fetch(request)
            
            
            for items in result as! [NSManagedObject] {
                let firstName = items.value(forKey: "firstName") as! String
                
                let lastName = items.value(forKey: "lastName") as! String
                self.userArray.append(firstName + " " + lastName)
            }
        }
        catch {
            print("error while fetching")
        }
    }
    
    
    
    
    
//delegate & datasource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TableViewCell"
        let cell = self.coredataTableView.dequeueReusableCell(withIdentifier: cellIdentifier,for: indexPath) as! TableViewCell
        cell.textLabel?.text = self.userArray[indexPath.row]
        
        return cell
    }
    
    
    
    
    
    
}
