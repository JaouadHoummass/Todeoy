//
//  TodoListTableViewController.swift
//  Todeoy
//
//  Created by Jaouad Hoummass on 2/11/19.
//  Copyright © 2019 Jaouad Hoummass. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController {
    
    let saveData = UserDefaults.standard
    
    var itemArray = ["Find Mike", "Buy Eggos","Destroy Demogorgon"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = saveData.array(forKey: "TodoListItems") as? [String] {
            
         itemArray = items
            
         print("Active")
    }
        
    }

   

    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = itemArray[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
          
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    
            
        } else {
            
           tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
          
        }
        
       tableView.deselectRow(at: indexPath, animated: true)
    }

    //MARK: Add Item to todoey List
   
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
        //creer un pointeur qui va pointer sur le alertTextField pour recuperer la valeur du text
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            self.itemArray.append(textField.text!)
            
            self.saveData.set(self.itemArray, forKey: "TodoListItems")
            
            self.tableView.reloadData()
            
        }
        
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextfield) in
            
          alertTextfield.placeholder = "Please Add New Item"
          textField = alertTextfield
            
        }
        
        
        
       present(alert, animated: true, completion: nil)
    
}
    
}
