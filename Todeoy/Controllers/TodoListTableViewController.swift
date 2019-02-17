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

    
    var itemArray : [Item] = []
    var dataArray : [Data] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        dataArray = (saveData.array(forKey: "ItemsList") as? [Data])!
       
        
        if let recoverDataArray  = saveData.array(forKey: "ItemsList") as? [Data] {
            
            for data in recoverDataArray {
                
            let item = NSKeyedUnarchiver.unarchiveObject(with: data) as! Item
            
            itemArray.append(item)

          }
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
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        if itemArray[indexPath.row].checked == false {
            
        cell.accessoryType = .none
            
        } else {
            
          cell.accessoryType = .checkmark
            
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
          
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        itemArray[indexPath.row].checked = false
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: itemArray[indexPath.row])
        dataArray[indexPath.row] = encodedData
        self.saveData.set(self.dataArray, forKey: "ItemsList")
        self.saveData.synchronize()
            
        } else {
            
           tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
           itemArray[indexPath.row].checked = true
           let encodedData = NSKeyedArchiver.archivedData(withRootObject: itemArray[indexPath.row])
           dataArray[indexPath.row] = encodedData
           self.saveData.set(self.dataArray, forKey: "ItemsList")
           self.saveData.synchronize()
        }
        
       tableView.deselectRow(at: indexPath, animated: true)
    }

    //MARK: Add Item to todoey List
   
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
        //creer un pointeur qui va pointer sur le alertTextField pour recuperer la valeur du text de ce dernier
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item(t:textField.text!, d:false )
            
            self.itemArray.append(newItem)
            
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: newItem)
            self.dataArray.append(encodedData)
            self.saveData.set(self.dataArray, forKey: "ItemsList")
            self.saveData.synchronize()
            
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
