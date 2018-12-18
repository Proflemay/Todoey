//
//  ViewController.swift
//  Todoey
//
//  Created by Philippe Lemay on 2018-12-06.
//  Copyright © 2018 LudoStudio. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    // var itemArray = ["Find Mike", "Buy Steak at Costco", "Destroy Demogorgon"]
    var itemArray = [Item]()
    // var itemArray = [Item(name: "Find Mike", state: false)]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newItem1 = Item()
        newItem1.name = "Find Mike"; newItem1.state = false
        itemArray.append(newItem1)
        let newItem2 = Item()
        newItem2.name = "Buy Steak at Costco"; newItem2.state = false
        itemArray.append(newItem2)
        let newItem3 = Item()
        newItem3.name = "Destroy Demagorgon"; newItem3.state = false
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    }
    
    //MARK - Tableview Datasource method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.name
        
        cell.accessoryType = item.state ? .checkmark : .none

        return cell
    }
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(itemArray[indexPath.row])
        itemArray[indexPath.row].state = !itemArray[indexPath.row].state
        
        if(tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark){
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("Table reloaded")
    }
    
    //MARK - Add new items
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new todoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            // what will happen
            // self.itemArray.append(textField.text!)
            let newItem = Item()
            newItem.name = textField.text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
            
        }
        
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
    

}

