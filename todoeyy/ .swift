//
//  ViewController.swift
//  todoeyy
//
//  Created by Anas on 11/11/1439 AH.
//  Copyright © 1439 Anas. All rights reserved.
//

import UIKit
import CoreData
class ToDoListViewController: UITableViewController, UISearchBarDelegate {

    let defualts = UserDefaults.standard
    
    var todolist = [Item]()
    
    let datapath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("item plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = Itemx()
       print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
       
    
//        if let list = defualts.array(forKey: "todoarray") as? [Item()] {
//            todolist = klist
//        }
        loaditems()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todolist.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellinuse", for: indexPath)
        cell.textLabel?.text = todolist[indexPath.row].title
        
        //cell.accessoryType = todolist[indexPath.row].check ? .checkmark : .none
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todolist[indexPath.row].check = !todolist[indexPath.row].check
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        saveitems()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func buttonpressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title:"add new item ? ", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "yep", style: .default) { (action) in
            let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            
            let newitem = Item(context: context!)
            newitem.title = textfield.text!
            newitem.check = false
            self.todolist.append(newitem)
            
            self.saveitems()
            self.tableView.reloadData()
        }
        alert.addTextField { (alerttextfield) in
            alerttextfield.placeholder = "create new item"
            textfield = alerttextfield
          
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveitems() {
    
        do {
            
            try context.save()
        
        }
        catch {
            print("error")
        }
       self.tableView.reloadData()
    }
    func loaditems(with req: NSFetchRequest<Item> = Item.fetchRequest()) {

        let req : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            todolist = try context.fetch(req)
        }catch{
            print("k")
        }
        tableView.reloadData()
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let reqm : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicar = NSPredicate(format: "title =[cd] %@", searchBar.text!)
        
        reqm.predicate = predicar
        
        print("llllll")
        print(searchBar.text!)
        
        
        let sortDescriptors = NSSortDescriptor(key: "title", ascending: true)
        
        reqm.sortDescriptors = [sortDescriptors]
        
        
        do {
            print("oppp")
    
            todolist = try context.fetch(reqm)
        }catch{
            print("k")
        }
        
        tableView.reloadData()
        loaditems(with: reqm)
        
        saveitems()
    }
    
}
//extension t: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let reqm : NSFetchRequest<Item> = Item.fetchRequest()
//        reqm.predicate = NSPredicate(format: "title CONTAINS[cd] %", searchBar.text!)
//        print("llllll")
//
//
//        reqm.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//
//        do {
//            todolist = try context.fetch(reqm)
//        }catch{
//            print("k")
//        }
//        tableView.reloadData()
//        loaditems(with: reqm)
//    }

//}

