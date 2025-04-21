//
//  CollectionsViewController+TableViewDelegate.swift
//  Flash Cards
//
//  Created by Novus on 19/04/2025.
//
import UIKit

extension CollectionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (_, _, completionHandler) in
            print("Trying to edit item at index \(indexPath.row)")
            completionHandler(true)
        }
        editAction.backgroundColor = .orange
        
        let config = UISwipeActionsConfiguration(actions: [editAction])
        config.performsFirstActionWithFullSwipe = true
        return config
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completionHandler) in
            self.showDeleteConfirmation(at: indexPath.row)
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = true
        return config
    }
}
