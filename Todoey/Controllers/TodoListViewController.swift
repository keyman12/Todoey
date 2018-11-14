//
//  ViewController.swift
//  Todoey
//
//  Created by David Key on 26/10/2018.
//  Copyright © 2018 Key Networking. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    var itemArray = [Item]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print (dataFilePath)
    
//
//        let newItem = Item()
//        newItem.title = "find mike"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "find Dave"
//        itemArray.append(newItem2)
//        
//        let newItem3 = Item()
//        newItem3.title = "find Geoff"
//        itemArray.append(newItem3)
        
        loadItems()
        
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
        
        saveItems()
        
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
        
       self.saveItems()
        }
            
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create new Item"
                textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to:dataFilePath!)
        } catch {
            print("Error encoding item array \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print(error)
            }
         
        }
    }
    
    
}


    
    


