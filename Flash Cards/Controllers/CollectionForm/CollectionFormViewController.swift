import UIKit
import FirebaseAuth
import FirebaseFirestore

class CollectionFormViewController: UIViewController {

    @IBOutlet weak var collectionNameTextField: UITextField!
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var translationTextField: UITextField!
    @IBOutlet weak var wordTableView: UITableView!

    var flashcardsList: [Flashcard] = []
    private let service = CollectionsService()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTapToDismissKeyboard()

        // 🧠 Tu w przyszłości dodasz sprawdzanie czy edytujemy kolekcję
    }

    // MARK: - Setup

    private func setupTableView() {
        wordTableView.dataSource = self
        wordTableView.register(
            UINib(nibName: K.CustomCells.wordTranslationCell, bundle: nil),
            forCellReuseIdentifier: K.CustomCells.reusableWordTranslationCell
        )
    }

    private func setupTapToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Actions

    @IBAction func addWordPressed(_ sender: UIButton) {
        guard
            let word = wordTextField.text, !word.isEmpty,
            let translation = translationTextField.text, !translation.isEmpty
        else {
            print("Word or translation missing")
            return
        }

        let flashcard = Flashcard(id: UUID(), word: word, translation: translation)
        flashcardsList.insert(flashcard, at: 0)
        setTextFieldsBlank()
        wordTableView.reloadData()
    }

    @IBAction func saveCollectionPressed(_ sender: UIButton) {
        saveCollection()
    }

    // MARK: - Save

    private func saveCollection() {
        guard let name = collectionNameTextField.text, !name.isEmpty else {
            print("Collection name cannot be empty")
            return
        }

        guard !flashcardsList.isEmpty else {
            print("Add some flashcards first!")
            return
        }

        guard let email = Auth.auth().currentUser?.email else {
            print("User not logged in")
            return
        }

        let newCollection = WordCollection(
            id: UUID(),
            owner: email,
            title: name,
            createdAt: Date().timeIntervalSince1970,
            words: flashcardsList
        )

        service.saveCollection(newCollection) { [weak self] success in
            guard let self = self else { return }

            if success {
                print("✅ Collection saved successfully")
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: K.Navigation.createCollectiontoCollectionsSegue, sender: self)
                }
            } else {
                print("❌ Failed to save collection")
            }
        }
    }

    private func setTextFieldsBlank() {
        wordTextField.text = ""
        translationTextField.text = ""
    }
}
