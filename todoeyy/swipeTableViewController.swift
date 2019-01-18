//
//  swipeTableViewController.swift
//  todoeyy
//
//  Created by Anas on 05/05/1440 AH.
//  Copyright © 1440 Anas. All rights reserved.
//

import UIKit
import SwipeCellKit
class swipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            
            self.updatemodel(at: indexPath)
//            u
//            if let currentc = self.lists?[indexPath.row] {
//                do {
//                    
//                    try self.realm.write {
//                        self.realm.delete(currentc)
//                    }
//                    
//                }
//                catch {
//                    print("error")
//                }
//            }
//            self.tableView.reloadData()
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")
        return [deleteAction]
    }
        
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        
        return options
    }
    func updatemodel(at indexpath : IndexPath) {
        
    }
}
