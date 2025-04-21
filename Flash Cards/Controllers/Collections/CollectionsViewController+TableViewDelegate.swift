//
//  CollectionsViewController+TableViewDelegate.swift
//  Flash Cards
//
//  Created by Novus on 21/04/2025.
//

import UIKit

extension CollectionsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { _, _, completion in
            print("Edit tapped for index \(indexPath.row)")
            completion(true)
        }
        editAction.backgroundColor = .orange
        return UISwipeActionsConfiguration(actions: [editAction])
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Usuń") { _, _, completion in
            self.showDeleteConfirmation(at: indexPath)
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
