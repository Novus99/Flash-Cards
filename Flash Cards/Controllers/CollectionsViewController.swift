//
//  File.swift
//  Flash Cards
//
//  Created by Novus on 12/04/2025.
//

import UIKit
import FirebaseAuth
import Firebase

class CollectionsViewController: UIViewController {
    
    
    @IBOutlet weak var collectionsTableView: UITableView!
    
    let db = Firestore.firestore()
    
    var collections: [WordCollection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCollections()
        collectionsTableView.delegate = self
        collectionsTableView.dataSource = self
        collectionsTableView.register(UINib(nibName: K.CustomCells.collectionCell, bundle: nil), forCellReuseIdentifier: K.CustomCells.reusableCollectionCell)
    }
    
    func loadCollections(){
        db.collection(Auth.auth().currentUser!.email!).order(by: K.FStore.dateField, descending: true).addSnapshotListener {
            (QuerySnapshot, error) in
            self.collections = []
            if let e = error {
                print("There was an issue retrieving data from Firestore. \(e)")
            }
            else {
                if let snapshotDocuments = QuerySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let collectionTitle = data[K.FStore.collectionTitle] as? String,
                           let collectionID = data[K.FStore.collectionID]{
                            let colID = UUID(uuidString: collectionID as! String)
                            let collection = WordCollection(
                                id: colID!,
                                owner: nil,
                                title: collectionTitle,
                                createdAt: nil,
                                words: nil
                            )
                            self.collections.append(collection)
                        }
                        print(self.collections)
                        DispatchQueue.main.async {
                            self.collectionsTableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    func deleteCollection(){
        
    }
}

extension CollectionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        collections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let collectionTitle = collections[indexPath.row].title
        print(collections[indexPath.row].title)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CustomCells.reusableCollectionCell, for: indexPath) as! CollectionCell
        cell.title.text = collectionTitle
        return cell
    }
    
}

extension CollectionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            print("Trying to edit item")
            completionHandler(true)
        }
        editAction.backgroundColor = .orange
        
        let swipeConfig = UISwipeActionsConfiguration(actions: [editAction])
        swipeConfig.performsFirstActionWithFullSwipe = true
        return swipeConfig
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath ) ->
    UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (action, view, completionHandler) in
            Task {
                let id = self.collections[indexPath.row].id
                do {
                    try await self.db.collection("\(Auth.auth().currentUser!.email!)").document(id.uuidString).delete()
                    DispatchQueue.main.async {
                        self.collectionsTableView.reloadData()
                    }
                    print("Document successfully removed!")
                } catch {
                    print("Error removing document: \(error)")
                }
                completionHandler(true)
            }
        }
        deleteAction.backgroundColor = .red
        
        let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeConfig.performsFirstActionWithFullSwipe = true
        return swipeConfig
    }
}


