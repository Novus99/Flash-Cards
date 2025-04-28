import UIKit
import FirebaseAuth
import FirebaseFirestore

class CollectionsViewController: UIViewController {

    @IBOutlet weak var collectionsTableView: UITableView!

    private let service = CollectionsService()
    var collections: [WordCollection] = []
    var isEditingCollection = false
    var selectedCollectionForEdit: WordCollection?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadCollections()
    }
    
    @IBAction func createCollectionPressed(_ sender: Any) {
        isEditingCollection = false
        selectedCollectionForEdit = nil
        performSegue(withIdentifier: K.Navigation.collectionsToCollectionFormSegue, sender: self)
    }
    
    private func setupTableView() {
        collectionsTableView.delegate = self
        collectionsTableView.dataSource = self
        collectionsTableView.register(
            UINib(nibName: K.CustomCells.collectionCell, bundle: nil),
            forCellReuseIdentifier: K.CustomCells.reusableCollectionCell
        )
    }

    private func loadCollections() {
        service.fetchCollections { [weak self] fetchedCollections in
            guard let self = self else { return }
            self.collections = fetchedCollections
            DispatchQueue.main.async {
                self.collectionsTableView.reloadData()
            }
        }
    }

    func showDeleteConfirmation(at indexPath: IndexPath) {
        guard indexPath.row < collections.count else {
            print("⚠️ Próba usunięcia nieistniejącej kolekcji")
            return
        }

        let alert = UIAlertController(
            title: "Czy na pewno chcesz usunąć tę kolekcję?",
            message: "Tej operacji nie można cofnąć.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Tak", style: .destructive) { _ in
            self.deleteItem(at: indexPath)
        })

        alert.addAction(UIAlertAction(title: "Nie", style: .cancel))
        present(alert, animated: true)
    }

    func deleteItem(at indexPath: IndexPath) {
        guard indexPath.row < collections.count else {
            print("⚠️ Index out of range przy usuwaniu")
            return
        }

        let collection = collections[indexPath.row]
        service.deleteCollection(id: collection.id) { success in
            if success {
                DispatchQueue.main.async {
                    print("✅ Kolekcja usunięta – Firestore listener zaktualizuje widok")
                    // NIE ruszamy collections ani tableView tutaj
                }
            }
        }
    }
    
    func editCollection(at indexPath: IndexPath) {
        let collection = collections[indexPath.row].title
        print("User is trying to edit collection \(collection)")
        isEditingCollection = true
        selectedCollectionForEdit = collections[indexPath.row]
        performSegue(withIdentifier: K.Navigation.collectionsToCollectionFormSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Navigation.collectionsToCollectionFormSegue,
           let destVC = segue.destination as? CollectionFormViewController {
            destVC.isEditMode = isEditingCollection
            destVC.collectionToEdit = selectedCollectionForEdit
        }
    }
}
    
