//
//  caterTableViewController.swift
//  todoeyy
//
//  Created by Anas on 15/04/1440 AH.
//  Copyright © 1440 Anas. All rights reserved.
//

import UIKit
import CoreData
class caterTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
loadcateritems()
        
    }
    
    var lists = [cater]()

    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
   
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "catercell", for: indexPath)
        cell2.textLabel?.text = lists[indexPath.row].names
        
        return cell2
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotoscreen", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destvc = segue.destination as? ToDoListViewController
        
        if let indexpath = tableView.indexPathForSelectedRow {
            destvc?.selectedcater = lists[indexpath.row]
        }
    }
    
    @IBAction func addbuttonpressed(_ sender: UIBarButtonItem) {
        var textfield2 = UITextField()
        let alert = UIAlertController(title:"wanna add new group list" , message: "", preferredStyle: .alert)
        
        
        
       let action = UIAlertAction(title: "Yeah!", style: .default) { (action) in
        let newitem = cater(context: self.context!)
        newitem.names = textfield2.text!
        self.lists.append(newitem)
        self.saveitems()
        self.tableView.reloadData()
        }
        
        alert.addTextField { (alerttextfield) in
            alerttextfield.placeholder = "create new lists"
            textfield2 = alerttextfield
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
        
        
    }
    
    func saveitems() {
        
        do {
            
            try context?.save()
            
        }
        catch {
            print("error")
        }
        self.tableView.reloadData()
    }
    
    func loadcateritems() {
        
        let req : NSFetchRequest<cater> = cater.fetchRequest()
        do {
            lists = (try context?.fetch(req))!
        }catch{
            print("k")
        }
        tableView.reloadData()
    }
    
}
