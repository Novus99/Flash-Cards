//
//  CollectionsViewController+TableViewDataSource.swift
//  Flash Cards
//
//  Created by Novus on 19/04/2025.
//

import UIKit

extension CollectionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        collections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CustomCells.reusableCollectionCell, for: indexPath) as! CollectionCell
        let collection = collections[indexPath.row]
        cell.title.text = collection.title
        return cell
    }
}
