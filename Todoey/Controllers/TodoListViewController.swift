//
//  ViewController.swift
//  Todoey
//
//  Created by David Key on 26/10/2018.
//  Copyright © 2018 Key Networking. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "find mike"
        itemArray.append(newItem)
    
        let newItem2 = Item()
        newItem2.title = "find Dave"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "find Geoff"
        itemArray.append(newItem3)
        
       if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
          itemArray = items
       }
        
    }
    

    
    
//MARK - Tableview Datasource Methods
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
        
    }
        
    //Mark - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        // print (itemArray[indexPath.row])
       
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    //MARK - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
      var textField = UITextField()
        
      let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
      let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the use clicks the add Item buttion on the UIAlrt
       
        let newItem = Item()
        newItem.title = textField.text!
        self.itemArray.append(newItem)
        
        self.defaults.set(self.itemArray, forKey: "TodoListArray")
        self.tableView.reloadData()
        }
            
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create new Item"
                textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

    
    


