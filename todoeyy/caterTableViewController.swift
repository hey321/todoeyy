//
//  caterTableViewController.swift
//  todoeyy
//
//  Created by Anas on 15/04/1440 AH.
//  Copyright © 1440 Anas. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class caterTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//
        loadcateritems()
        
    }
    
    var lists: Results<caterg>?

    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    var realm = try! Realm()
   
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "catercell", for: indexPath)
        cell2.textLabel?.text = lists?[indexPath.row].names ?? "nothing added yet"
        
        return cell2
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotoscreen", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destvc = segue.destination as? ToDoListViewController
        
        if let indexpath = tableView.indexPathForSelectedRow {
            destvc?.selectedcater = lists?[indexpath.row]
        }
    }
    
    @IBAction func addbuttonpressed(_ sender: UIBarButtonItem) {
        var textfield2 = UITextField()
        let alert = UIAlertController(title:"wanna add new group list" , message: "", preferredStyle: .alert)
        
        
        
       let action = UIAlertAction(title: "Yeah!", style: .default) { (action) in
        
       
        let newitem = caterg()
        newitem.names = textfield2.text!
       
        self.save(cat: newitem)
        self.tableView.reloadData()
        }
        
        alert.addTextField { (alerttextfield) in
            alerttextfield.placeholder = "create new lists"
            textfield2 = alerttextfield
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
        
        
    }
    
    func save(cat : caterg) {
        
        do {
            
            try realm.write {
                realm.add(cat)
            }
            
        }
        catch {
            print("error")
        }
        self.tableView.reloadData()
    }
    
    func loadcateritems() {
        
       lists = realm.objects(caterg.self)
        tableView.reloadData()
    }
//
}
