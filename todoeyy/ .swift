//
//  ViewController.swift
//  todoeyy
//
//  Created by Anas on 11/11/1439 AH.
//  Copyright © 1439 Anas. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework
class ToDoListViewController: swipeTableViewController, UISearchBarDelegate {

    var selectedcater : caterg? {
        didSet{
            loaditems()
        }
    }
    let defualts = UserDefaults.standard
     let realm = try! Realm()
    var todoitems: Results<itemb>?
    
    let datapath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("item plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
        _ = Itemx()
       print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
       
    
//        if let list = defualts.array(forKey: "todoarray") as? [Item()] {
//            todolist = klist
//        }
        loaditems()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let clrhx = selectedcater?.color {
            title = clrhx
            guard let mll = navigationController?.navigationBar else {fatalError()}
            if let nclr = UIColor(hexString: clrhx) {
            mll.barTintColor = nclr
            mll.tintColor = ContrastColorOf(nclr, returnFlat: true)
                mll.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : ContrastColorOf(nclr, returnFlat: true) ]
                search.barTintColor = nclr
                
                
            }
        }
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = FlatRed()
    }
    @IBOutlet weak var search: UISearchBar!
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoitems?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = todoitems?[indexPath.row].title ?? "no items added?"
        
        if let clr = UIColor(hexString: (selectedcater?.color)!)?.darken(byPercentage: CGFloat(indexPath.row)/CGFloat((todoitems?.count)!)) {
                  cell.backgroundColor = clr
            cell.textLabel?.textColor = ContrastColorOf(clr, returnFlat: true)
        }
    
        cell.accessoryType = (todoitems?[indexPath.row].check)! ? .checkmark : .none
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if let item = todoitems?[indexPath.row]{
            do {
                
                try realm.write {
                    
                    item.check = !item.check
                
                }
                
            }
            catch {
                print("error")
            }
    }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
//    @IBAction func editbutton(_ sender: UIBarButtonItem) {
//
//
//
//
//
//        do {
//
//            try realm.write {
//                realm.delete(<#T##object: Object##Object#>)
//
//
//            }
//
//        }
//        catch {
//            print("error")
//
//        }
//
//    }
    
    
    
    @IBAction func buttonpressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title:"add new item ? ", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "yep", style: .default) { (action) in
            
            if let current = self.selectedcater {
                do {
                    
                    try self.realm.write {
                        
                        let newitem = itemb()
                        newitem.title = textfield.text!
                        newitem.datecreated = Date()
                        current.items.append(newitem)
                      
                        
                    }
                    
                }
                catch {
                    print("error")
                }
                
            }
           
           
          
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alerttextfield) in
            alerttextfield.placeholder = "create new item"
            textfield = alerttextfield
          
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
 
    func loaditems() {

        todoitems = selectedcater?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }

    override func updatemodel(at indexpath: IndexPath) {
        if let currentc = self.todoitems?[indexpath.row] {
            do {
                
                try self.realm.write {
                    self.realm.delete(currentc)
                }
                
            }
            catch {
                print("error")
            }
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoitems = todoitems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "datecreated", ascending: true)
        
        tableView.reloadData()
//
//
       
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loaditems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}
