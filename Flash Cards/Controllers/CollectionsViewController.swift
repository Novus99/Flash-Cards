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
    
    var collections: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCollections()
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
                        if let collectionTitle = data[K.FStore.collectionTitle] as? String{
                            self.collections.append(collectionTitle)
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
}

extension CollectionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        collections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let collectionTitle = collections[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CustomCells.reusableCollectionCell, for: indexPath) as! CollectionCell
        cell.title.text = collectionTitle
        return cell
    }
    
}
