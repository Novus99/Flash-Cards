//
//  CollectionCreationViewController.swift
//  Flash Cards
//
//  Created by Novus on 24/03/2025.
//
import UIKit
import FirebaseAuth
import FirebaseFirestore

class CollectionFormViewController: UIViewController {
    
    @IBOutlet weak var collectionNameTextField: UITextField!
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var translationTextField: UITextField!
    @IBOutlet weak var wordTableView: UITableView!
    
    var flashcardsList : [Flashcard] = []
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tapGesture)
        	
    }
    
    private func setupTableView() {
        wordTableView.dataSource = self
        wordTableView.delegate = self
        wordTableView.register(UINib(nibName: K.CustomCells.wordTranslationCell, bundle: nil), forCellReuseIdentifier: K.CustomCells.reusableWordTranslationCell)
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
    
     func removeFlashcard(at index: Int) {
        guard index < flashcardsList.count else {
            print("Próba usunięcia flashcard spoza zakresu")
            return
        }
        flashcardsList.remove(at: index)
        wordTableView.reloadData()
    }
}
