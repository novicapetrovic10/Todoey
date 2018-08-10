//
//  ViewController.swift
//  Todoey
//
//  Created by Novica Petrovic on 10/08/2018.
//  Copyright © 2018 Novica Petrovic. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    //itemArray contains all the elements we want to put in our Todo list (hard-coded for now)
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
        
    }

    //MARK: - Tableview Datasource Methods
    
    //This method creates the number of rows needed in our tableView by counting the number of items in our itemArray
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //This method populates the TodoItemCells with the data from the itemArray
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Cell created using dequeueReusableCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        //Cell populated with text from itemArray
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Swift Ternary Operator
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        //The above statement is the equivalent of the code below
        
        //if itemArray[item].done == true {
        //      cell.accessoryType = .checkmark
        //  } else {
        //      cell.accessoryType = .none
        //  }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    
    //This method prints out the corresponding item in the itemArray when it's selected in the tableView
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen when the user clicks the Add Item button on our UIAlert
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.setValue(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

