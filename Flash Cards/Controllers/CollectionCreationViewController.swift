//
//  CollectionCreationViewController.swift
//  Flash Cards
//
//  Created by Novus on 24/03/2025.
//
import UIKit
import FirebaseAuth
import FirebaseFirestore

class CollectionCreationViewController: UIViewController {
    
    @IBOutlet weak var collectionNameTextField: UITextField!
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var translationTextField: UITextField!
    @IBOutlet weak var wordTableView: UITableView!
    
    var flashcardsList : [Flashcard] = []
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordTableView.dataSource = self
        wordTableView.register(UINib(nibName: K.CustomCells.wordTranslationCell, bundle: nil), forCellReuseIdentifier: K.CustomCells.reusableWordTranslationCell)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tapGesture)
        	
    }
    
    @IBAction func addWordPressed(_ sender: UIButton) {
        if let word = wordTextField.text, !word.isEmpty, let translation = translationTextField.text, !translation.isEmpty {
            let flashcard = Flashcard(id: UUID(),word: word, translation: translation)
            flashcardsList.insert(flashcard, at: 0)
            setTextFieldsBlank()
            wordTableView.reloadData()
            print (flashcardsList)
        }
        else{
            print("Word or translation missing")
        }
    }
    
    @IBAction func saveCollectionPressed(_ sender: UIButton) {
        guard let collectionName = collectionNameTextField.text, !collectionName.isEmpty else {
               print("Collection name cannt be empty")
               return
           }
           
           guard !flashcardsList.isEmpty else {
               print("Add some flashcards first!")
               return
           }
           
           let newWordCollection = WordCollection(
               id: UUID(),
               owner: (Auth.auth().currentUser?.email)!,
               title: collectionName,
               createdAt: Date().timeIntervalSince1970,
               words: flashcardsList
           )
        print(newWordCollection)
        do {
            try db.collection("\(Auth.auth().currentUser!.email!)").document(newWordCollection.id.uuidString)
                .setData(from: newWordCollection)
            print("Document added succesfully!")
            performSegue(withIdentifier: K.Navigation.createCollectiontoCollectionsSegue, sender: self)
        }   catch {
            print("Error while adding document: \(error)")
        }
       }
    
    func setTextFieldsBlank(){
        wordTextField.text = ""
        translationTextField.text = ""
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension CollectionCreationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flashcardsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let word = flashcardsList[indexPath.row].word
        let translation = flashcardsList[indexPath.row].translation
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CustomCells.reusableWordTranslationCell, for: indexPath) as! WordTranslationCell
        cell.wordLabel.text = word
        cell.translationLabel.text = translation
        return cell
    }
}
