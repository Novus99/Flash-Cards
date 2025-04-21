//
//  CollectionFormViewController+TableViewDelegate.swift
//  Flash Cards
//
//  Created by Novus on 21/04/2025.
//

import UIKit

extension CollectionFormViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Usuń") { _, _, completion in
            self.removeFlashcard(at: indexPath.row)
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
}
