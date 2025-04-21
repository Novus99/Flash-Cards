//
//  CollectionsViewController+TableViewDataSource.swift
//  Flash Cards
//
//  Created by Novus on 21/04/2025.
//
import UIKit

extension CollectionsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < collections.count else {
            print("Index \(indexPath.row) poza zakresem kolekcji")
            return UITableViewCell()
        }

        let collection = collections[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.CustomCells.reusableCollectionCell, for: indexPath) as? CollectionCell else {
            print("Nie udało się zrzutować komórki na CollectionCell")
            return UITableViewCell()
        }

        cell.title.text = collection.title
        return cell
    }
}
