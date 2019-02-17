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
    
        
        
        if let recoverDataArray  = saveData.array(forKey: "ItemsList") as? [Data] {
            
            dataArray = recoverDataArray
            
            for data in dataArray {
                
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
        
        let item = itemArray[indexPath.row]
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "TodoCell")
        //let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        

        // Configure the cell...
        cell.textLabel?.text = item.title
        
        //Ternary Operator
        cell.accessoryType = item.checked == true ? .checkmark : .none
        
//        if item.checked == false {
//
//        cell.accessoryType = .none
//
//        } else {
//
//          cell.accessoryType = .checkmark
//
//        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = itemArray[indexPath.row]
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
          
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        item.checked = false
        updateData(item: item, indexPath: indexPath)
            
        } else {
            
           tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
           item.checked = true
           updateData(item: item, indexPath: indexPath)
        }
        
       tableView.deselectRow(at: indexPath, animated: true)
    }

    //MARK: Add Item to todoey List
   
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item(t:textField.text!, d:false )
            
            self.itemArray.append(newItem)
            
            self.addData(item : newItem)
            
            self.tableView.reloadData()
            
        }
        
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextfield) in
            
          alertTextfield.placeholder = "Please Add New Item"
          textField = alertTextfield
            
        }
        
        
        
       present(alert, animated: true, completion: nil)
    
}
    
    func addData(item : Item) {
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: item)
        self.dataArray.append(encodedData)
        self.saveData.set(self.dataArray, forKey: "ItemsList")
        self.saveData.synchronize()
        
    }
    
    func updateData(item : Item, indexPath : IndexPath) {
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: item)
        dataArray[indexPath.row] = encodedData
        self.saveData.set(self.dataArray, forKey: "ItemsList")
        self.saveData.synchronize()
        
    }
    
}
