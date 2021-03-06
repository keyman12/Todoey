//
//  ViewController.swift
//  Todoey
//
//  Created by David Key on 26/10/2018.
//  Copyright © 2018 Key Networking. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
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
       
//        context.delete(itemArray[indexPath.row])
//         itemArray.remove(at: indexPath.row)
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
      var textField = UITextField()
        
      let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
      let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the use clicks the add Item buttion on the UIAlrt
       
        
        let newItem = Item(context: self.context)
        newItem.title = textField.text!
        newItem.done = false
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
        do {
          try context.save()
        } catch {
          print("Error Saving Context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
   func loadItems() {
    let request : NSFetchRequest<Item> = Item.fetchRequest()
    
    do {
    itemArray = try context.fetch(request)

    }catch {
        print("Error fetching data from context \(error)")
    }
    }
}
//MARK: Search bar methods
extension TodoListViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
       request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        do {
            itemArray = try context.fetch(request)
            
        }catch {
            print("Error fetching data from context \(error)")
        }
         tableView.reloadData()
        
    
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            tableView.reloadData()
            DispatchQueue.main.async{
            searchBar.resignFirstResponder()
            }

            
        }
    }
}




    


    
    


