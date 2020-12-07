//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Daniel Rivera on 11/25/20.
//  Copyright © 2020 Daniel Rivera. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()

    var categories: Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }
//MARK: - Data Manipulation Methods
    func save(category: Category){
        
        do {
        
            try realm.write{
                realm.add(category)
            }
                
        } catch {
            print("Error saving item array to persistant container. \(error) ")
                
        }
                
        self.tableView.reloadData()
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
           
        tableView.reloadData()

       }
    
    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
               
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
               
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
                   
                       
                       
                    let newCategory = Category()
                
                    newCategory.name = textField.text!
                         
                    self.save(category: newCategory)

               }
               alert.addAction(action)
               alert.addTextField { (alertTextField) in
                   alertTextField.placeholder = "Create New Category"
                   
                   textField = alertTextField
                   
               }
               
               
               present(alert, animated: true, completion: nil)
    
    }
    
    
    //MARK: - TableView Datasource Methods
    
    
   
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Cateogries Added Yet"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
              performSegue(withIdentifier: "goToItems", sender: nil)
          }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCategory = categories?[indexPath.row]
            
        
        }
    }
    
}
