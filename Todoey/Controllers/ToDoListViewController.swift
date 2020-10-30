//
//  ViewController.swift
//  Todoey
//
//  Created by Daniel Rivera on 9/25/20.
//  Copyright © 2020 Daniel Rivera. All rights reserved.
//

import UIKit

class ToDoListViewController:  UITableViewController {

    var itemListArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        let newItem1 = Item()
        newItem1.title = "Daniel"
        itemListArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Laura"
        itemListArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "House"
        itemListArray.append(newItem3)
        
        
        if let itemArray = defaults.array(forKey: "ToDoLists") as? [Item] {
            itemListArray = itemArray
        }
    }
    
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return itemListArray.count
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemListArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK - Tableview Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
        itemListArray[indexPath.row].done = !itemListArray[indexPath.row].done
        
        tableView.reloadData()
        
    
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items Section
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
         
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let addText = textField.text {
                
                let newItem = Item()
                newItem.title = addText
                self.itemListArray.append(newItem)
                self.defaults.set(self.itemListArray, forKey: "ToDoLists")
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            
            textField = alertTextField
            
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    

}

