//
//  ViewController.swift
//  coreDataProject
//
//  Created by Puja Kumari on 4/4/17.
//  Copyright © 2017 nineleaps. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var searchFirstNameField: UITextField!
    @IBOutlet weak var searchLabel: UILabel!
    
    
    
    
    var items = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func saveUser(_ sender: UIButton) {
        
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName:"User", into: context)
        
        newUser.setValue(self.firstNameField.text, forKey: "firstName")
        newUser.setValue(self.lastNameField.text, forKey: "lastName")
        
        do{
            try context.save()
        }catch{
            print("Error while saving the data")
        }
    }
    
    @IBAction func showDetails(_ sender: UIButton) {
        
    }
    
    @IBAction func deleteUser(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Delete User Details", message: "Are u sure you want to continue", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Delete", style: .default, handler: { action in
            
            let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.managedObjectContext
            let request = NSFetchRequest<NSFetchRequestResult> (entityName: "User")
            print(User())
            
            let searchString:String = self.searchFirstNameField.text!
            //let secondSearchString:String = self.searchFirstNameField.text!
            
            //   let texts = searchString.components(separatedBy: " ")
            // let firstText = texts.first!
            // let lastText = texts.last!
            
            request.predicate = NSPredicate(format:"firstName == '\(searchString)'")
            
            
            
            
            print( (request), "Request")
            if let result = try? context.fetch(request) {
                
                for object in result {
                    context.delete(object as! NSManagedObject)
                }
            }
            
            do{
                
                
                try context.save()
                
                
            } catch{
                print("Error in fetching the data")
            }
            
        })
        alertController.addAction(okAction)
        
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func searchName(_ sender: Any) {
        
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        let searchString:String = self.searchFirstNameField.text!
        request.predicate = NSPredicate(format: "firstName == '\(searchString)'")
        
        do{
            let results = try context.fetch(request)
            if results.count > 0{
                let firstname = (results[0] as AnyObject).value(forKey: "firstName") as! String
                let lastname =  (results[0] as AnyObject).value(forKey: "lastName")  as! String
                self.searchLabel.text = firstname + lastname
            }else {
                self.searchLabel.text = "No Results Found"
            }
            
        }catch{
            print("Error in fetching results")
        }
    }
}
