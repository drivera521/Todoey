//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Daniel Rivera on 11/25/20.
//  Copyright © 2020 Daniel Rivera. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }
//MARK: - Data Manipulation Methods
    func saveCategory(){
        
        do {
        
            try context.save()
                
        } catch {
            print("Error saving item array to persistant container. \(error) ")
                
        }
                
        self.tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()){
           
           do {
             categories = try context.fetch(request)
           } catch {
               print("Error fetching data from context \(error)")
           }
           
           tableView.reloadData()

       }
    
    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
               
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
               
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
                   
                       
                       
                    let newCategory = Category(context: self.context)
                
                    newCategory.name = textField.text!
                    
                    self.categories.append(newCategory)
                         
                    self.saveCategory()

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
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
              performSegue(withIdentifier: "goToItems", sender: nil)
          }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCategory = categories[indexPath.row]
            
        
        }
    }
    
}
