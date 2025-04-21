import UIKit
import FirebaseAuth

class CollectionsViewController: UIViewController {

    @IBOutlet weak var collectionsTableView: UITableView!

    var collections: [WordCollection] = []
    private let service = CollectionsService()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadCollections()
    }

    private func setupTableView() {
        collectionsTableView.delegate = self
        collectionsTableView.dataSource = self
        collectionsTableView.register(UINib(nibName: K.CustomCells.collectionCell, bundle: nil), forCellReuseIdentifier: K.CustomCells.reusableCollectionCell)
    }

    private func loadCollections() {
        service.fetchCollections { collections in
            self.collections = collections
            DispatchQueue.main.async {
                self.collectionsTableView.reloadData()
            }
        }
    }

    private func deleteItem(at index: Int) {
        let id = collections[index].id
        service.deleteCollection(with: id) { error in
            if let error = error {
                print("Error deleting collection: \(error)")
            } else {
                self.collections.remove(at: index)
                DispatchQueue.main.async {
                    self.collectionsTableView.reloadData()
                }
            }
        }
    }

     func showDeleteConfirmation(at index: Int) {
        let confirm = UIAlertAction(title: "Yes", style: .destructive) { _ in
            self.deleteItem(at: index)
        }
        let cancel = UIAlertAction(title: "No", style: .cancel)

        presentAlert(
            title: "Do you really want to delete this collection?",
            message: "This operation is irreversable.",
            actions: [confirm, cancel]
        )
    }

    private func presentAlert(title: String, message: String, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alertController.addAction($0) }
        self.present(alertController, animated: true)
    }
}
