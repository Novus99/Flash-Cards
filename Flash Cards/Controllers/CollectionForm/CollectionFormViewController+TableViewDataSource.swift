//
//  CollectionFormViewController+TableView.swift
//  Flash Cards
//
//  Created by Novus on 21/04/2025.
//

import UIKit

extension CollectionFormViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flashcardsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let flashcard = flashcardsList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CustomCells.reusableWordTranslationCell, for: indexPath) as! WordTranslationCell
        cell.wordLabel.text = flashcard.word
        cell.translationLabel.text = flashcard.translation
        return cell
    }
}
