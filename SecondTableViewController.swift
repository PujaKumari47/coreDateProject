//
//  SecondTableViewController.swift
//  coreDataProject
//
//  Created by Puja Kumari on 4/18/17.
//  Copyright © 2017 nineleaps. All rights reserved.
//

import UIKit

class SecondTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var coredataTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.coredataTableView.delegate = self
         self.coredataTableView.dataSource = self
       
    }
//delegate & datasource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TableViewCell"
        let cell = self.coredataTableView.dequeueReusableCell(withIdentifier: cellIdentifier,for: indexPath) as! TableViewCell
        
        
        return cell
    }
    
    
    
    
    
    
}
