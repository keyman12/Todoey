//
//  CategoryViewController.swift
//  Todoey
//
//  Created by David Key on 21/11/2018.
//  Copyright © 2018 Key Networking. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var itemArray = [Categories]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
    //MARK: - TableView Datasource methods
    

    
    //MARK: - Data Manipulation Methods
    
    
    
    
    
    //MARK: - TableView Delegate Methods
    
    
    
    
    
    
}
